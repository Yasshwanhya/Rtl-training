`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.05.2024 02:04:32
// Design Name: 
// Module Name: muladd_poadd
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


module muladd_poadd#(parameter DataWidth = 32)(
    input [DataWidth-1:0] a,
    input [DataWidth-1:0] b,
    input [DataWidth-1:0] c,
    output reg [(2*DataWidth):0] d
    );
    
    always @(*)
    begin
          d = ( a * b ) + c ;
    end
endmodule

