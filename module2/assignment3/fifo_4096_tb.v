`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.04.2024 09:54:15
// Design Name: 
// Module Name: fifo_4096_tb
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


module fifo_4096_tb();

parameter DataWidth = 16;
parameter Depth = 4096;
parameter PtrWidth = ($clog2(Depth))/2;
parameter MAX_VALUE = (2**PtrWidth) - 1;

reg clk, rst; 
reg [DataWidth-1:0] data_in;
reg rd, wr;
wire empty1;
wire full1;
wire empty2;
wire full2;

wire empty;
wire full;
wire [DataWidth-1:0] data_out1;
wire [DataWidth-1:0] data_out2;

fifo_4096#(DataWidth, Depth, PtrWidth, MAX_VALUE ) dutest (
clk, rst, data_in, rd, wr,empty1,full1,empty2,full2, empty, full, data_out1, data_out2);

   
// Clock Generation
 initial 
    begin
        clk = 0;
        forever #10 clk = ~clk;
    end
    
    
//reset
initial begin
      rst = 1'b1;
      #40;
      rst = 1'b0;
end
   integer i=0;
initial begin
    @(posedge clk)data_in = i;
    forever #20 data_in = data_in+2;
 end


initial
begin
rd = 0; wr = 1;
#50000;
rd = 1; wr =0;
#500000;
/*rd = 1; wr = 1;
#5000;
rd = 0; wr = 0;
#5000;
wr = 1;
#500;
wr = 0; rd =1;*/
end
     
endmodule

