`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.06.2024 14:56:02
// Design Name: 
// Module Name: adderfp_tb
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


module adderfp_tb();


 
       reg clk;
       //reg rst;
       reg signed [int1+frac1-1:0]a;
       reg signed [int2+frac2-1:0]b;
       reg sign_add;
       wire overflow;
       wire underflow;
       wire signed [out_int+out_frac-1:0]sum;
       
       
       parameter int1=6;
       parameter frac1=7;
       parameter int2=7;
       parameter frac2=9;
       parameter out_int=4;
       parameter out_frac=3;


adder1#(int1,frac1,int2,frac2,out_int,out_frac)dut(clk,a,b,sign_add,overflow,underflow,sum);
  

//Clock Generation Block
initial
begin
     clk = 0;
     forever #20 clk = ~clk;
end

//Reset generation block
//initial
//begin
//     rst = 0;
//     #60;
//     rst = 1;
//end

//a and b combinations
initial
begin
    a=13'b0101110110011;
    b=16'b1110111000010101;
    sign_add=1;
    #80;
    a=13'b0000001000001;
    b=16'b0000001000000000;
    sign_add=0;
    #80;
    a=13'b1010101100011;
    b=16'b1010100011100001;
    sign_add=1;
    #80;
    a=13'b0101111110011;
    b=16'b1001011010101101;
    sign_add=0;
    #80;
    a=13'b0001001010111;
    b=16'b1011001000110111;
    sign_add=1;
    #80;
    a=13'b1000000100111;
    b=16'b0001101011000111;
    sign_add=0;
    #80;
end




endmodule
