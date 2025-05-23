`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.04.2025 20:33:54
// Design Name: 
// Module Name: Instruction_Memory
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


module Instruction_Memory
(
    input logic [31:0] A, 
    output logic [31:0] RD
);

/*
Memory Map 
8000_0000 ->2000_0000
8000_FFFF ->2000_3FFF

Only 30 bits (from MSB) from PC output needed.

*/


logic [31:2] A_0;
logic [31:0] mem [30'h2000_0000 : 30'h2000_3FFF]; 

initial begin  

$readmemh("./imem.mem",mem); //this is for assignment


end 


always_comb  begin

    A_0 = A[31:2];
    
    RD= mem[A_0];
end


endmodule
