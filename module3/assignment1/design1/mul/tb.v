`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.05.2024 15:06:59
// Design Name: 
// Module Name: design_1_mul_tb
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


module design_1_mul_tb();

 parameter DataWidth = 16;
    reg [DataWidth-1:0] a;
    reg [DataWidth-1:0] b;
    wire [(2*DataWidth):0] c;
   
   
design_1_mul #(DataWidth)a1 (a,b,c);
initial begin
a= 0; b=0;
end
initial begin
forever #20 a = a + 2;
end
initial begin
forever #20 b = b + 5;
end

endmodule
