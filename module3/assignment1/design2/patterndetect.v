`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.05.2024 10:43:05
// Design Name: 
// Module Name: one
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


module one#(
    parameter input_width = 16,
//    parameter input_2_width = 10,
    parameter output_width = 2*input_width,
    parameter pattern = 20'd36
)(
    input clk,
    input rst,
    input [input_width:0] A,
    input [input_width:0] B,
    output [output_width:0] C,
    output reg pattern_detection
);

reg [output_width:0] ab;
reg [input_width:0] A1;
reg [input_width:0] B1;

always @(posedge clk) 
begin
  if(!rst)
  begin
    A1 <= 0;
    B1 <= 0;
  end
  else
  begin
    A1 <= A;
    B1 <= B;
    ab <= A1 * B1;
  end
end



always @(*) 
begin
    if (ab == pattern)
    begin
        pattern_detection <= 1'b1;
    end 
    else 
    begin
        pattern_detection <= 1'b0;
    end
end

assign C = ab;
endmodule




