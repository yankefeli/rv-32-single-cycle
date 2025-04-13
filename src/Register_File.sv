`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.04.2025 20:01:20
// Design Name: 
// Module Name: Register_File
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


module Register_File
(
    input logic [4:0] A1,A2,A3,
    input logic clk, WE3,reset,
    input logic [31:0] WD3, 
    output logic [31:0] RD1,RD2
);

logic [31:0] file [31:0]; //register file
integer i;


always_ff @(posedge clk or negedge reset ) begin

    if(!reset) begin
        for(i=0; i<=31;i=i+1)   // register reset 
        file [i] =0;
    end
    
    else
    if(WE3)  file[A3] = WD3;
    
end    


always_comb  begin
    file[5'b00000]=32'd0;
    
    RD1= file[A1];
    RD2= file[A2];
end


endmodule
