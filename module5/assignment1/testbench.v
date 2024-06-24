`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.06.2024 16:11:07
// Design Name: 
// Module Name: assign1_tb
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


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.06.2024 16:25:55
// Design Name: 
// Module Name: fsm1_tb
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


module assign1_tb();
reg clk,rst;
reg [15:0]s_data;
reg s_valid,s_last;
wire s_ready;
reg [7:0]t_keep;
wire  [15:0] m_data;
wire m_valid,m_last;
reg m_ready;
wire [7:0]m_keep;integer i;reg rd_en;
reg [11:0]m,k;
assign1 f1(clk, rst, s_data, s_valid, s_last, s_ready, t_keep, m_data, m_valid, m_last, m_ready, m_keep, rd_en);
always #5 clk=~clk;
initial begin
clk=1;rst=0;m_ready=0;m=0;
#5;rst=1;
#25;
m_ready=1;

for(i=0;i<=25;i=i+1)
 begin
s_data=$urandom;
s_valid=1;
if(i==10 | i==20)
s_last<=1;
else
s_last<=0;
//if(s_valid & s_ready)
//m=m+1;
//if(s_last)
//k=m;
#10;
end
end
initial begin

#25;t_keep<=7'd16;
#10;t_keep<=7'd16;
#10;t_keep<=7'd8;
#10;t_keep<=7'd4;
#10;t_keep<=7'd12;
#10;t_keep<=7'd16;
#10;t_keep<=7'd4;
#10;t_keep<=7'd8;
#10;t_keep<=7'd12;
#10;t_keep<=7'd8;
#10;t_keep<=7'd16;
#10;t_keep<=7'd12;
#10;t_keep<=7'd16;
#10;t_keep<=7'd12;
#10;t_keep<=7'd16;
#10;t_keep<=7'd12;
#10;t_keep<=7'd16;
end

initial begin
#80;
rd_en=1;
end

endmodule
