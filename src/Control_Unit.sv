`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.04.2025 23:42:21
// Design Name: 
// Module Name: Control_Unit
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


module Control_Unit
(
    input  logic [6:0] op,
    input  logic [14:12] funct3,
    input  logic funct7, Zero,
    output logic PCSrc, MemWrite, ALUSrc, RegWrite,
    output logic [1:0] ResultSrc, TargetSrc,
    output logic [2:0] ImmSrc,
    output logic [3:0] ALUControl
);

logic Branch0, Jump0,  MemWrite0, ALUSrc0, RegWrite0;
logic [1:0] ResultSrc0, ALUOp0,TargetSrc0;
logic [2:0] ImmSrc0;
logic [3:0] ALUControl0;
logic flag;

Main_Decoder m_dec (.op(op), .Branch(Branch0), .Jump(Jump0), .MemWrite(MemWrite0),
 .ALUSrc(ALUSrc0), .RegWrite(RegWrite0)
, .ResultSrc(ResultSrc0), .ImmSrc(ImmSrc0), .ALUOp(ALUOp0), .TargetSrc(TargetSrc0) );

ALU_dec alu_dec (.opb5(op[5]), .funct3(funct3), .funct7b5(funct7), .ALUOp(ALUOp0),
 .ALUControl(ALUControl0));

always_comb begin
    
    case (funct3[12])
        1'b0: flag = Zero;
        1'b1: flag = ~Zero;
    endcase
    
    PCSrc= (flag & Branch0) | Jump0;
    MemWrite= MemWrite0;
    ALUSrc= ALUSrc0;
    RegWrite= RegWrite0;
    ///////////////////////////
    ResultSrc= ResultSrc0; 
    ImmSrc= ImmSrc0;
    TargetSrc = TargetSrc0;
    /////////////////////////
    ALUControl = ALUControl0;
end

endmodule
