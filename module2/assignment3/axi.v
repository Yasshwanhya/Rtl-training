`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.04.2024 10:16:03
// Design Name: 
// Module Name: axi
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


module axi#(
parameter DataWidth = 16,   
parameter Depth = 4096,
parameter PtrWidth = ($clog2(Depth))/2,
parameter MAX_VALUE = (2**PtrWidth) - 1
)
(
      input clk,rst,
      
      input [DataWidth-1:0]s_data,
      input s_valid,
      output reg s_ready,
      input s_last,
      
      output reg [DataWidth-1:0]m_data,
      output reg m_valid,
      input m_ready,
      output reg m_last,
      
      output [DataWidth-1:0]data_out1,
      output [DataWidth-1:0]data_out2,
      
      output full,
      output empty
   );
   
   wire rd,wr,ready;
   reg valid,last;
   wire [DataWidth-1:0]m_data_reg;
   wire e1,e2,f1,f2;
   assign ready = m_ready;
   always @(posedge clk)
   begin
           if(rst)
           begin
                   valid<=0;
                   last<=0;
           end
           else
           begin
                   if(s_valid && ready)
                   begin
                            valid<=s_valid;
                             last<=s_last;
                   end
                   else
                   begin
                            valid<=0;
                             last<=0;
                   end
           end
   end
   
   assign rd = (s_valid && ready) ;
   assign wr =(s_valid && ready) || (s_valid==1'b1);
   
   fifo_4096#(DataWidth, Depth, PtrWidth, MAX_VALUE ) fifo (
clk, rst, s_data, rd, wr, e1,f1,e2,f2,empty, full, data_out1, data_out2);                  
    
    assign m_data_reg = e2?data_out1:data_out2 ;
    
    always @(posedge clk)
    begin
            if(s_valid && ready)
            begin 
                    m_data <=  m_data_reg;
                    m_valid <= valid;
                    m_last <= last;
                    s_ready <= ready;
            end
    end
endmodule
