`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.04.2025 23:50:40
// Design Name: 
// Module Name: core_adder
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


module core_adder
(
    input logic [31:0] a_i,b_i,
    output logic [31:0] sum 
);

genvar j;
logic [31:0] C_I;
logic [31:0] C_O;
integer i;
logic [31:0] n1;
logic [31:0] n2;
logic [31:0] B;

generate 
    for (j=0; j<=31; j=j+1)  begin
        full_adder uut (.a(a_i[j]), .b(b_i[j]), .c(C_I[j]), .cr(n1[j]), .s(n2[j]));
    end
endgenerate

always_comb begin
    
    C_I[0]=0;
    C_O = n1;
    
    for(i=0;i<=30;i=i+1) begin
        C_I[i+1] = C_O[i];
    end
    
    sum = n2;
end

endmodule
