`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.06.2024 16:21:43
// Design Name: 
// Module Name: assign_2_tb
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


module assign_2_tb();

     reg clk;
     reg rst;
     
     //slave port
     reg [15:0] s_data;
     reg s_valid;
     wire s_ready;
     reg s_last;
     reg [7:0] s_keep;
     
     //configuration port
     reg rd_en;
     reg [15:0]block_length;
     wire last_block;

     //master port
     wire [15:0] m_data;
     wire m_valid;
     reg m_ready;
     wire m_last;
     wire [7:0] m_keep;
     
     assign2 dut (clk, rst, s_data, s_valid, s_ready, s_last, s_keep, m_data, m_valid, m_ready, m_last, m_keep, rd_en, block_length, last_block);
     
     //clock generation
     initial
     begin
          clk = 0;
          forever #20 clk = ~clk;
     end
     
     //reset assigning
     initial
     begin
          rst = 0;
          #50;
          rst = 1;
     end
     
     //ready and valid signals
     initial
     begin
          m_ready = 0; s_valid = 0;
          #40;
          m_ready = 1; s_valid = 1; 
     end
     
     //read enable signal and block length
     initial
     begin
          rd_en = 0;
          #40;
          rd_en = 1;
          block_length = 10;
     end
     integer i;
     //data and last signals
     initial
     begin
          s_data = 0;
          s_last = 0;
          #50;
          for( i=0 ; i<20 ; i = i+1)
          begin
               s_data = $urandom;
               if( i==8 | i==16 )
               s_last = 1;
               else
               s_last = 0;
               #40;
          end
     end
     
     //keep signal generation
     initial 
     begin
          #25;s_keep<=7'd16;
          #10;s_keep<=7'd16;
          #10;s_keep<=7'd8;
          #10;s_keep<=7'd4;
          #10;s_keep<=7'd12;
          #10;s_keep<=7'd16;
          #10;s_keep<=7'd4;
          #10;s_keep<=7'd8;
          #10;s_keep<=7'd12;
          #10;s_keep<=7'd8;
          #10;s_keep<=7'd16;
          #10;s_keep<=7'd12;
          #10;s_keep<=7'd16;
          #10;s_keep<=7'd12;
          #10;s_keep<=7'd16;
          #10;s_keep<=7'd12;
          #10;s_keep<=7'd16;
     end



endmodule
