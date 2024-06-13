`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.06.2024 14:39:32
// Design Name: 
// Module Name: fpmultiply_tb
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


module fpmultiply_tb();
      
       reg clk;
       reg rst;
       reg signed [int1+frac1-1:0]a;
       reg signed [int2+frac2-1:0]b;
       wire signed [out_int+out_frac-1:0]product;
       wire overflow;
       wire underflow;
       
       
       
       parameter int1=6;
       parameter frac1=8;
       parameter int2=5;
       parameter frac2=7;
       parameter out_int=6;
       parameter out_frac=9;


fpmultiply #(int1, frac1, int2, frac2, out_int, out_frac ) dut ( clk, rst, a, b, overflow, underflow, product );
 
initial begin
    clk=1'b0;
    forever #10 clk = ~clk;
end

initial begin
     rst = 1'b1;
    #20 rst =1'b0;
end

initial begin
    
    a=14'b10111111001111;
    b=14'b10110100011111;
    #110;
    
    a=14'b10100100101001;
    b=14'b10010010110001;
    #110;
    
    a=14'b11111111111111;
    b=14'b11111111111111;
    #110;
    
    a=14'b10101010100101;
    b=14'b00111010101010;
    #110;
    
    a=14'b10111101100111;
    b=14'b11111100000000;
    #110;
    
    a=14'b01011010001101;
    b=14'b00011100001111;
    #110;
    
//    a=14'b;
//    b=14'b;
//    #110;
    
//    a=14'b;
//    b=14'b;
//    #110;
    
//    a=14'b;
//    b=14'b;
     
end
  

endmodule
