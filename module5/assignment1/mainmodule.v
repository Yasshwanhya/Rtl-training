`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.06.2024 15:06:05
// Design Name: 
// Module Name: assignment1
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


module assignment1(
    input clk,
    input rst,
    
    input [15:0]s_data,
    input s_valid,
    input t_keep,
    output  s_ready,
    input s_last,
    
    output reg [15:0]m_data,
    output reg m_valid,
    output reg m_keep,
    input m_ready,
    output reg m_last

    );
    
    reg [3:0]data[128:0];
    reg [5:0] wr_ptr, rd_ptr;
    reg rd_en;
    reg [3:0] state,next_state;
    parameter s0=3'd0,s1=3'd1,s2=3'd2,s3=3'd3,s4=3'd4,idle=3'd5;
    assign s_ready=m_ready;
    reg [6:0]r2,r3,r4,r1;
    reg [15:0]count;
    reg last;
    
    
    always @(posedge clk)
    begin
         if (~rst)
         begin
              rd_en = 0;
              wr_ptr<=0;
              rd_ptr<=0;
              count<=0;
              state<=idle;
         end
         else
         begin
              rd_en = s_valid&&m_ready;
              state<=next_state;
         end
    end
    
    always @(posedge clk)
    begin
          case(state)
          idle:begin
                     next_state <= s0;
                 end
          s0  :begin
                   if(rd_en)
                   begin
                      if(t_keep==7'd0)
                         next_state=s0;
                      else if(t_keep==7'd4)
                         next_state=s1;
                      else if(t_keep==7'd8)
                         next_state=s2;
                      else if(t_keep==7'd12)
                         next_state=s3;
                      else if(t_keep==7'd16)
                         next_state=s4;
                   end
               end
          s1  :begin
                   if(rd_en)
                   begin
                      if(t_keep==7'd0)
                         next_state=s0;
                      else if(t_keep==7'd4)
                         next_state=s1;
                      else if(t_keep==7'd8)
                         next_state=s2;
                      else if(t_keep==7'd12)
                         next_state=s3;
                      else if(t_keep==7'd16)
                         next_state=s4;
                   end
               end
          s2  :begin
                   if(rd_en)
                   begin
                      if(t_keep==7'd0)
                         next_state=s0;
                      else if(t_keep==7'd4)
                         next_state=s1;
                      else if(t_keep==7'd8)
                         next_state=s2;
                      else if(t_keep==7'd12)
                         next_state=s3;
                      else if(t_keep==7'd16)
                         next_state=s4;
                   end
               end
          s3  :begin
                   if(rd_en)
                   begin
                      if(t_keep==7'd0)
                         next_state=s0;
                      else if(t_keep==7'd4)
                         next_state=s1;
                      else if(t_keep==7'd8)
                         next_state=s2;
                      else if(t_keep==7'd12)
                         next_state=s3;
                      else if(t_keep==7'd16)
                         next_state=s4;
                   end
               end
          s4  :begin
                   if(rd_en)
                   begin
                      if(t_keep==7'd0)
                         next_state=s0;
                      else if(t_keep==7'd4)
                         next_state=s1;
                      else if(t_keep==7'd8)
                         next_state=s2;
                      else if(t_keep==7'd12)
                         next_state=s3;
                      else if(t_keep==7'd16)
                         next_state=s4;
                   end
               end  
    endcase
    end
    
    always@(posedge clk)
    begin
    case(next_state)
    s0:begin
        wr_ptr<=0;
       end
    s1:begin
       data[wr_ptr]<=s_data[3:0];
       wr_ptr<=wr_ptr+1;   
       end
    s2:begin
       data[wr_ptr]<=s_data[3:0];
       data[wr_ptr+1]<=s_data[7:4];
       wr_ptr<=wr_ptr+2;
       end
    s3:begin
       data[wr_ptr]<=s_data[3:0];
       data[wr_ptr+1]<=s_data[7:4];
       data[wr_ptr+2]<=s_data[12:8];
       wr_ptr<=wr_ptr+3;
       end
    s4:begin
       data[wr_ptr]<=s_data[3:0];
       data[wr_ptr+1]<=s_data[7:4];
       data[wr_ptr+2]<=s_data[11:8];
       data[wr_ptr+3]<=s_data[15:12];
       wr_ptr<=wr_ptr+4;
       end
    
    endcase
    end  
    
     always@(posedge clk)
    begin
    case(next_state)
    s0:r1=0;
    s1:r1=1;
    s2:r1=2;
    s3:r1=3;
    s4:r1=4;
    endcase
    
    end
     always@(posedge clk)
        begin
             if(s_last==1)
               begin
                 r2<=wr_ptr;
                 r3<=wr_ptr+r1-1;
                 r4<=rd_ptr;
               end
        end
        always@(posedge clk)
          begin
            if(rd_en)
              begin
                 if(r2==rd_ptr ) 
                    begin
                       m_data={{data[rd_ptr+3]},{data[rd_ptr+2]},{data[rd_ptr+1]},{data[rd_ptr]}};
                       rd_ptr<=rd_ptr+4;
                       m_keep<=7'd16;
                       m_valid<=1;
                       m_last=1;
                    end
               else if(r2==rd_ptr+1)
                    begin
                        m_data<={{4'b0},{4'b0},{4'b0},{data[rd_ptr]}};
                        rd_ptr<=rd_ptr+1;
                        m_keep<=7'd4;
                        m_valid<=1;m_last=1;
                        r2=0;   
                    end
              else if(r2==rd_ptr+2)
                   begin
                       m_data<={{4'b0},{4'b0},{data[rd_ptr+1]},{data[rd_ptr]}};
                       rd_ptr<=rd_ptr+2;
                       m_keep<=7'd8;
                       m_valid<=1;
                       m_last=1;
                       r2=0; 
                  end
             else if(r2==rd_ptr+3)
                   begin          
                      m_data<={{4'b0},{data[rd_ptr+2]},{data[rd_ptr+1]},{data[rd_ptr]}};
                      rd_ptr<=rd_ptr+3;
                      m_keep<=7'd12;
                      m_valid<=1;
                      m_last=1;
                      r2=0; 
                   end 
          end
          else
        begin
        m_data=0;
        m_valid=0;
        m_last=0;
        m_keep=0;
        end
          end
          
       
endmodule
