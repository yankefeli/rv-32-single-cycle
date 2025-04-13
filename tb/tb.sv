`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.04.2025 13:50:08
// Design Name: 
// Module Name: tb
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

module tb();

  logic [31:0] addr;
  logic [31:0] data;
  logic [31:0] pc;
  logic [31:0] instr;
  logic [                4:0] reg_addr;
  logic [31:0] reg_data;
  logic [31:0] mem_addr;
  logic [31:0] mem_data;
  logic                       mem_wrt;
  logic                       update;
  logic                       clk;
  logic                       rstn;

  riscv_singlecycle i_core_model (
      .clk_i(clk),
      .rstn_i(rstn),
      .addr_i(addr),
      .update_o(update),
      .data_o(data),
      .pc_o(pc),
      .instr_o(instr),
      .reg_addr_o(reg_addr),
      .reg_data_o(reg_data),
      .mem_addr_o(mem_addr),
      .mem_data_o(mem_data),
      .mem_wrt_o(mem_wrt)

  );
  
  integer file_pointer;
  initial begin
    file_pointer = $fopen("model.log", "w");
    #4
    forever begin
      if (update) begin
        if (reg_addr == 0) begin
          $fwrite(file_pointer, "0x%8h (0x%8h)", pc, instr);
        end else begin
          if (reg_addr > 9) begin
            $fwrite(file_pointer, "0x%8h (0x%8h) x%0d 0x%8h", pc, instr, reg_addr, reg_data);
          end else begin
            $fwrite(file_pointer, "0x%8h (0x%8h) x%0d  0x%8h", pc, instr, reg_addr, reg_data);
          end
        end
        if (mem_wrt == 1) begin
          $fwrite(file_pointer, "mem 0x%8h 0x%8h", mem_addr, mem_data);
        end
        $fwrite(file_pointer, "\n");
      end
      #2;
    end
  end
  
  initial
    forever begin
      clk = 0;
      #1;
      clk = 1;
      #1;
    end
  initial begin
    rstn = 0;
    #4;
    rstn = 1;
    #10000;
    for (logic [31:0] i = 32'h8000_0000; i < 32'h8000_0000 + 'h20; i = i + 4) begin
      addr = i;
      #4;
      $display("data @ mem[0x%8h] = %8h", addr, data);
      
    end
    $finish;
  end


  initial begin
    $dumpfile("dump.vcd");
    $dumpvars();
  end


endmodule
