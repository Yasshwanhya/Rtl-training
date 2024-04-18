`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.04.2024 10:58:36
// Design Name: 
// Module Name: axi_tb
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


module axi_tb();

parameter DataWidth = 16; 
parameter Depth = 4096;
parameter PtrWidth = ($clog2(Depth))/2;
parameter MAX_VALUE = (2**PtrWidth) - 1;

reg clk,rst;
      
reg [DataWidth-1:0]s_data;
reg s_valid;
wire s_ready;
reg s_last;
      
wire [DataWidth-1:0]m_data;
wire m_valid;
reg m_ready;
wire m_last;
      
wire [DataWidth-1:0]data_out1;
wire [DataWidth-1:0]data_out2;
      
wire full;
wire empty;
 
 axi#(DataWidth, Depth, PtrWidth, MAX_VALUE )
 test ( clk, rst, s_data, s_valid, s_ready, s_last, m_data, m_valid, m_ready,m_last, data_out1,data_out2, full, empty); 

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
    @(posedge clk)s_data = i;
    forever #20 s_data = s_data+2;
 end

initial
begin
s_valid = 1;
#10000;
s_valid = 0;
#1000;
s_valid = 1;
end

initial 
begin
m_ready = 0;
#1000;
m_ready = 1;
#20000;
m_ready = 0;
end

initial
begin
forever
begin
repeat(7) @(posedge clk)s_last = 0;
@(posedge clk)s_last = 1;
end
end

endmodule
