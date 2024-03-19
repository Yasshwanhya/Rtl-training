`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.03.2024 10:57:36
// Design Name: 
// Module Name: mux_trial_tb
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


module mux_trial_tb();

//port declarations
reg clk;
reg reset;
    
    //Selection line
reg select;
    
    //Slave-1 inputs
reg [7:0]s1_data;
reg s1_valid;
wire s1_ready;
reg s1_last;
    
    //Slave-2 inputs
reg [7:0]s2_data;
reg s2_valid;
wire s2_ready;
reg  s2_last;
    
    //master
wire [7:0]m_data;
wire m_valid;
reg m_ready;
wire m_last;
  
//DUT Instantiation
mux_trial m1 ( clk, reset, select, s1_data, s1_valid, s1_ready, s1_last, s2_data, s2_valid, s2_ready, s2_last, m_data, m_valid, m_ready, m_last);

//cases
initial
 begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial 
  begin
    reset = 0;
    #15;
    reset = 1;
    #10 ;
    reset = 0;
  end

initial 
  begin
     s1_valid = 0;s2_valid = 0;
     m_ready = 0;
     s1_last = 0;s2_last = 0;
     s1_data = $random;
     s2_data = $random;
     #10;
  end

initial 
begin
    select = 0;
    forever # 100 select = ~select;  
end

initial 
begin
    m_ready = 0;
    forever #50 m_ready = ~m_ready;  
end


initial
begin 
repeat(3)
begin
    repeat(3)
    begin
        @(posedge clk)
        s1_valid = s1_valid + 1;
        s1_last = 0;
        s1_data = $random;
    end
    s1_last = 1;
    s1_data = $random;
    #10;
    s1_last = 0;s1_data= 0;
    s1_valid = 0;
    #30;
end  
end

initial
begin
repeat(3)
begin
    repeat(7)
    begin
        @(posedge clk)
        s2_valid = s2_valid + 1;
        s2_last = 0;
        s2_data = $random;
    end
    s2_last = 1;
    s2_data = $random;
    #10;
    s2_last = 0;s2_data= 0;
    s2_valid = 0;
    #30;
end    
end
endmodule
