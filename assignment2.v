`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.03.2024 17:00:14
// Design Name: 
// Module Name: mux_trial
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


module mux_trial(
    input clk,
    input reset,
    
    //Selection line
    input select,
    
    //Slave-1 inputs
    input [7:0]s1_data,
    input s1_valid,
    output reg s1_ready,
    input  s1_last,
    
    //Slave-2 inputs
    input [7:0]s2_data,
    input s2_valid,
    output reg s2_ready,
    input  s2_last,
    
    //master
    output reg [7:0]m_data,
    output reg m_valid,
    input m_ready,
    output  m_last
  
    );
    
    reg [7:0]data;
    reg valid;
    reg r1,r2 ;
    reg last;
    
    always@(negedge clk) 
    begin
    valid <= select ?  s2_valid : s1_valid;
    r1 <= select ? 0 : m_ready;
    r2 <= select ? m_ready : 0 ;
    end

always@(negedge clk ) 
begin
    if(reset) 
    begin
        data <= 0;
        valid <= 0;
        r1 <= 0; r2 <= 0;
        last <=0;   
    end
    else 
    begin
     if (~select) 
     begin
          if(s1_valid && m_ready)
          data <= s1_data;
          else
          data<=0;
     end
     if( select) 
     begin
           if(s2_valid && m_ready)
           data <= s2_data;
           else
           data <=0;
      end
     end
end

always @(negedge clk)
begin
    if(reset) 
    begin
        m_data <= 0;
        m_valid <= 0;
        s1_ready <= 0;
        s2_ready <=0;
        
    end
    else
    begin
       s1_ready <= r1;
       s2_ready <= r2;
       m_data <= data;
       m_valid <= valid;
    end
end
always@(negedge clk)
begin
    last <= select ? s2_last : s1_last;
    end
assign m_last = last;
    
endmodule

