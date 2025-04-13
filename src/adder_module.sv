`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.04.2025 23:05:37
// Design Name: 
// Module Name: adder_module
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


module adder_module
(
    input logic [31:0] A_i,
    input logic [31:0] B_i,
    input logic Sel_i, 
    output logic [31:0] Sum_o,
    output logic C_o,
    output logic Overflow
);

logic [31:0] C_I;
logic [31:0] C_O;
integer i;
genvar j;
logic [31:0] n1;
logic [31:0] n2;
logic [31:0] B;
logic [32:0] full;
//assign n1 = C_O;
//assign n2 = Sum_o;
//assign C_i = C_I[0];
generate 
    
    for (j=0; j<=31; j=j+1) begin
        full_adder uut (.a(A_i[j]), .b(B[j]), .c(C_I[j]), .cr(n1[j]), .s(n2[j]));
    end
endgenerate

always_comb begin
    
    if(Sel_i == 0)
    C_I[0]= 0;
    //C_I[0]= C_i;
    else 
    //C_I[0]=C_i;
    C_I[0]=1;
    
    for(i=0;i<=31;i=i+1) begin
        B[i] = B_i[i] ^ Sel_i;
    end
    
    C_O = n1;
    
    for(i=0;i<=30;i=i+1) begin
        C_I[i+1] = C_O[i];
    end
    
    Sum_o = n2;
    C_o = C_O[31];
    Overflow = C_O[31] ^ C_O[30];
    full= {C_o, Sum_o};
end

endmodule
