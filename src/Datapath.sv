`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.04.2025 00:25:51
// Design Name: 
// Module Name: Datapath
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module Datapath
(
    input logic PCSrc,MemWrite, ALUSrc ,RegWrite, clk, rstn_i,
    input logic [3:0] ALUControl,
    input logic [1:0] ResultSrc, TargetSrc,
    input logic [2:0] ImmSrc,
    input logic [31:0] addr_i,
    output logic [31:0] Instr,
    output logic [31:0] data_o,
    output logic [31:0] pc_o,
    output logic [4:0] reg_addr_o,
    output logic [31:0] reg_data_o,
    output logic [31:0] mem_addr_o,
    output logic [31:0] mem_data_o,
    output logic        mem_wrt_o,
    output logic Zero
);


logic [31:0] pc, instr, Result, SrcA, rd2, immext, PCTarget, four, PCPlus4, PCNext, SrcB, ALUResult, ReadData, Target;             
logic[31:0] srcb, pcnext, result,target;
logic [19:15] a1;
logic [24:20] a2;
logic [11:7] a3;
logic z;
 
 
assign four =32'h4;
assign a1 = instr[19:15];
assign a2 = instr[24:20];
assign a3 = instr[11:7];

assign pc_o = pc;
assign reg_addr_o = a3;
assign reg_data_o = Result;
assign mem_addr_o = ALUResult;
assign mem_data_o = ReadData;
assign mem_wrt_o = MemWrite;

                                   
Instruction_Memory d0 (.A(pc) , .RD(instr));   

Register_File d1(.A1(a1) , .A2(a2), .A3(a3), .clk(clk), .WE3(RegWrite), .WD3(Result), .RD1(SrcA), .RD2(rd2), .reset(rstn_i));  
         
Extend d2 (.Instr(instr[31:7]), .ImmSrc(ImmSrc), .ImmExt(immext));      
        
PC d3 (.PCNext(PCNext), .CLK(clk), .PC(pc), .reset(rstn_i)); 

ALU d4 (.A(SrcA), .B(SrcB), .F(ALUResult), .Zero(z),.op(ALUControl)); 

Data_Memory d5 (.A(ALUResult), .WD(rd2), .CLK(clk), .WE(MemWrite), .RD(ReadData), .funct3(instr[14:12]), .addr_i(addr_i), .data_o(data_o)); 

   
core_adder adder0 (.a_i(Target), .b_i(immext), .sum(PCTarget));
core_adder adder1 (.a_i(pc), .b_i(four), .sum(PCPlus4));        
        
assign SrcB = srcb;        
assign PCNext = pcnext;
assign Result = result;        
assign Target = target;
        
always_comb begin 
    Instr = instr;      
    Zero = z;
    //
    //pcnext = PCNext;
    //srcb = SrcB;
    //result = Result;
    
    case(PCSrc) 
        1'b0 : pcnext = PCPlus4;
        1'b1 : pcnext = PCTarget; 
    endcase
                  
    case(ALUSrc)
        1'b0 : srcb = rd2;
        1'b1 : srcb = immext;
    endcase             
    
    case(ResultSrc)
        2'b00: result = ALUResult;           
        2'b01: result = ReadData;
        2'b10: result = PCPlus4;    
        2'b11: result = PCTarget;                  
    endcase         
    
    case(TargetSrc)
        2'b00: target = 32'h0;
        2'b01: target = pc;
        2'b10: target =SrcA;
    endcase
    
end

endmodule
