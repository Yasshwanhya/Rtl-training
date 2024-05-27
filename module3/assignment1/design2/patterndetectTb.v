`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.05.2024 00:36:45
// Design Name: 
// Module Name: one_tb
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


module one_tb();

    parameter input_width = 16;
    //parameter input_2_width = 10;
    parameter output_width = 2*input_width;
    parameter pattern = 20'd36;

    reg clk;
    reg rst;
    reg [input_width:0] A;
    reg [input_width:0] B;
    wire [output_width:0] C;
    wire pattern_detection;

one#(input_width,  output_width,pattern ) dut (clk,rst,A,B, C,pattern_detection);

initial
begin
clk = 0;
forever #10 clk=~clk;
end

initial
begin
rst = 0;
#40;
rst = 1;
end


initial
begin
A=0;
repeat(20) @(posedge clk) A=A+1;
A=0;
repeat(20) @(posedge clk) A=A+1;
A=0;
repeat(20) @(posedge clk) A=A+1;
A=0;
repeat(20) @(posedge clk) A=A+1;
end


initial
begin
B=0;
repeat(20) @(posedge clk)B=2;
repeat(20) @(posedge clk)B=3;
repeat(20) @(posedge clk)B=4;
repeat(20) @(posedge clk)B=5;
end




endmodule
