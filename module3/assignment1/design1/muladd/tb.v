`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.05.2024 07:12:50
// Design Name: 
// Module Name: design_1_muladd_tb
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


module design_1_muladd_tb();

parameter DataWidth = 16;
reg [DataWidth-1:0] a;
reg [DataWidth-1:0] b;
reg [DataWidth-1:0] c;
wire [(2*DataWidth):0] d;

design_1_muladd#(DataWidth)d1(a,b,c,d );

initial begin
a = 0;
b = 1;
c = 2;
end
initial begin
forever #10 a = a+1;
end
initial begin
forever #20 b = b+2;
end
initial begin
forever #30 c = c+3;
end
endmodule
