`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.04.2025 23:01:17
// Design Name: 
// Module Name: Barrel_shift
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


module Barrel_shift
(
    input logic [31:0] A,B,
    input logic [1:0] shifter_op,
    output logic [31:0] o
);

genvar i;
logic [31:0] A_16,B_16, A_8,B_8, A_4,B_4, A_2,B_2, A_1,B_1;
logic [31:0] n1,n2,n3,n4,n5;
logic sign_bit;
logic [15:0] sign_mem;
integer j;
logic [31:0] B0;


always_comb begin
    
    B0= { {27{1'b0}} , B[4:0]  };
    
    if(shifter_op == 2'b00) begin //saga kaydir
       
       A_16=  {16'b0,A[31:16]};
       B_16=  {16'b0,B0[31:16]};
       
       A_8=  {8'b0,n1[31:8]};
       B_8=  {8'b0,n1[31:8]};
       
       A_4=  {4'b0,n2[31:4]};
       B_4=  {4'b0,n2[31:4]};
       
       A_2=  {2'b0,n3[31:2]};
       B_2=  {2'b0,n3[31:2]};
       
       A_1=  {1'b0,n4[31:1]};
       B_1=  {1'b0,n4[31:1]};
       
    end
    
    if(shifter_op == 2'b10) begin //sola kaydir
        
        A_16=  {A[15:0],16'b0};
        B_16=  {B0[15:0],16'b0};
        
        A_8=  {n1[23:0],8'b0};
        B_8=  {n1[23:0],8'b0};
        
        A_4=  {n2[27:0],4'b0};
        B_4=  {n2[27:0],4'b0};
        
        A_2=  {n3[29:0],2'b0};
        B_2=  {n3[29:0],2'b0};
        
        A_1=  {n4[30:0],1'b0};
        B_1=  {n4[30:0],1'b0};
        
    end
    
    if(shifter_op == 2'b01) begin //saga kaydir (aritmetik)
       
       sign_bit=A[31];
       
       for (j=0;j<16;j=j+1)
       sign_mem[j] = sign_bit;
       
       A_16=  {sign_mem,A[31:16]};
       B_16=  {sign_mem,B0[31:16]};
       
       A_8=  {sign_mem[7:0],n1[31:8]};
       B_8=  {sign_mem[7:0],n1[31:8]};
       
       A_4=  {sign_mem[3:0],n2[31:4]};
       B_4=  {sign_mem[3:0],n2[31:4]};
       
       A_2=  {sign_mem[1:0],n3[31:2]};
       B_2=  {sign_mem[1:0],n3[31:2]};
       
       A_1=  {sign_mem[0],n4[31:1]};
       B_1=  {sign_mem[0],n4[31:1]};
    end
    o=n5;
end


generate 
    for(i=0; i<32; i=i+1) begin
        MUX bit_16 (.a(A[31-i]), .b(A_16[31-i]),.s(B0[4]) , .o(n1[31-i]) );
        MUX bit_8 (.a(n1[31-i]), .b(A_8[31-i]), .s(B0[3]) , .o(n2[31-i]) );
        MUX bit_4 (.a(n2[31-i]), .b(A_4[31-i]), .s(B0[2]) , .o(n3[31-i]) );
        MUX bit_2 (.a(n3[31-i]), .b(A_2[31-i]), .s(B0[1]) , .o(n4[31-i]) );
        MUX bit_1 (.a(n4[31-i]), .b(A_1[31-i]), .s(B0[0]) , .o(n5[31-i]) );
    end
endgenerate


endmodule
