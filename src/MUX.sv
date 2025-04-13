`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.04.2025 22:50:45
// Design Name: 
// Module Name: MUX
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


module MUX
(
    input logic a,b,s,
    output logic o
);
    
always_comb begin
    
    case(s)
        1'b0: o=a;
        1'b1: o=b;
    endcase
    
end
    
     
endmodule
