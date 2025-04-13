`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.04.2025 00:51:34
// Design Name: 
// Module Name: riscv_singlecycle
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


module riscv_singlecycle
#(
    //parameter DMemInitFile  = "dmem.mem",       // data memory initialization file
    parameter IMemInitFile  = "imem.mem",       // instruction memory initialization file
    parameter XLEN = 32
)
(
    input  logic             clk_i,       // system clock
    input  logic             rstn_i,      // system reset
    input  logic  [XLEN-1:0] addr_i,      // memory adddres input for reading
    output logic  [XLEN-1:0] data_o,      // memory data output for reading
    output logic             update_o,    // retire signal
    output logic  [XLEN-1:0] pc_o,        // retired program counter
    output logic  [XLEN-1:0] instr_o,     // retired instruction
    output logic  [     4:0] reg_addr_o,  // retired register address
    output logic  [XLEN-1:0] reg_data_o,  // retired register data
    output logic  [XLEN-1:0] mem_addr_o,  // retired memory address
    output logic  [XLEN-1:0] mem_data_o,  // retired memory data
    output logic             mem_wrt_o   // retired memory write enable signal
);


logic PCSrc1,MemWrite1, ALUSrc1 ,RegWrite1;
logic [3:0] ALUControl1;
logic [2:0] ImmSrc1;
logic [1:0] ResultSrc1, TargetSrc1;
logic zero1, clk_reg;
logic [31:0] Instr1;
logic [31:0] reg_addr_o_1;

assign instr_o = Instr1;


Datapath datapath (.PCSrc(PCSrc1), .MemWrite(MemWrite1), .ALUSrc(ALUSrc1), .RegWrite(RegWrite1),
 .clk(clk_i), .TargetSrc(TargetSrc1), .ALUControl(ALUControl1)
, .ImmSrc(ImmSrc1), .ResultSrc(ResultSrc1), .Zero(zero1), .Instr(Instr1),
.addr_i(addr_i), .rstn_i(rstn_i), .data_o(data_o), .pc_o(pc_o), .reg_addr_o(reg_addr_o_1),
.reg_data_o(reg_data_o), .mem_addr_o(mem_addr_o), .mem_data_o(mem_data_o), .mem_wrt_o(mem_wrt_o) ); 

Control_Unit ctrl (.op(Instr1[6:0]) , .funct3(Instr1[14:12]), .funct7(Instr1[30]), .Zero(zero1), .PCSrc(PCSrc1),
.MemWrite(MemWrite1), .ALUSrc(ALUSrc1), .RegWrite(RegWrite1), .ResultSrc(ResultSrc1),
 .ImmSrc(ImmSrc1), .ALUControl(ALUControl1),
 .TargetSrc(TargetSrc1) );

//assign update_o = 1;
assign update_o = (pc_o!=32'h8000_20c8)  ? 1 : 0;
assign reg_addr_o = (Instr1[6:0] == 99) ? 32'h0 : reg_addr_o_1;

endmodule
