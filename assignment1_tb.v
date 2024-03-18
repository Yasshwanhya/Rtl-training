`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.03.2024 11:12:29
// Design Name: 
// Module Name: testbench
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


module testbench;

reg clk,rst;
    
//slave
reg [7:0]s_data;
reg s_valid;
wire s_ready;
reg s_last;
    
//master
wire [7:0]m_data;
wire m_valid;
reg m_ready;
wire m_last;


axi_8bit a5(.clk(clk), .rst(rst),
                          .s_data(s_data),
                          .s_valid(s_valid),
                          .s_ready(s_ready),
                          .s_last(s_last),
                          .m_data(m_data),
                          .m_valid(m_valid),
                          .m_ready(m_ready),
                          .m_last(m_last)       );
                          
initial
 begin
    clk = 0;
    forever #2 clk = ~clk;
end

initial begin
    rst = 0;
    #5;
    rst = 1;
    #4 ;
    rst = 0;
end

initial begin
s_valid = 0;
m_ready = 0;
s_last = 0;
s_data = $random;
#10;

repeat(7)
begin
@(posedge clk)
s_valid = 1;
m_ready = 1;
s_last = 0;
s_data = $random;
end
s_last = 1;s_data = $random;
#4;
s_last = 0;s_data= 0;
#1;


repeat(7)
begin
@(posedge clk)
s_valid = 1;
m_ready = 0;
s_last = 0;
s_data = $random;
end
s_last = 1;s_data = $random;
#4;
s_last = 0;s_data= 0;
#1;

repeat(7)
begin
@(posedge clk)
s_valid = 0;
m_ready = 1;
s_last = 0;
s_data = $random;
end
s_last = 1;s_data = $random;
#4;
s_last = 0;s_data= 0;
#1;


repeat(7)
begin
@(posedge clk)
s_valid = ~s_valid;
m_ready = ~m_ready;
s_last = 0;
s_data = $random;
end
s_last = 1;s_data = $random;
#4;
s_last = 0;s_data= 0;
#1;

repeat(7)
begin
@(posedge clk)
s_valid = 1;
m_ready = 1;
s_last = 0;
s_data = $random;
end
s_last = 1;s_data = $random;
#4;
s_last = 0;s_data= 0;
#1;
end



endmodule
