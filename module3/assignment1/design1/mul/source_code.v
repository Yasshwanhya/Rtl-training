`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.05.2024 14:29:58
// Design Name: 
// Module Name: design_1_mul
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


module design_1_mul #(parameter DataWidth = 32)(
    input [DataWidth-1:0] a,
    input [DataWidth-1:0] b,
    output reg [(2*DataWidth):0] c
    );
    
    always @(*)
    begin
          c = a * b;
    end
endmodule
