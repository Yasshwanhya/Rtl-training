`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.06.2024 11:06:36
// Design Name: 
// Module Name: assign2
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


module assign2(
     input clk,
     input rst,
     
     //slave port
     input [15:0] s_data,
     input s_valid,
     output s_ready,
     input s_last,
     input [7:0] s_keep,
     
     //master port
     output reg [15:0] m_data,
     output reg m_valid,
     input m_ready,
     output reg m_last,
     output reg [7:0] m_keep,
     
     //configuration port
     input rd_en,
     input [15:0]block_length,
     output reg last_block
     );
     
     //registers
     reg [7:0] r2,r3,r4,r1;
     
     //data storing queue
     reg [3:0]queue[64:0];
     
     //reading and writing pointers
     reg [15:0] rd_ptr, wr_ptr;
     reg [15:0] count;
     
     //states and parameters
     reg [3:0] state, next_state;
     parameter s0=3'd0, s1=3'd1, s2=3'd2, s3=3'd3, s4=3'd4, idle=3'd5;
     
     //assigning ready
     assign s_ready = m_ready;
     
     //state considerations
     always @(posedge clk)
     begin
           if(~rst)
           begin 
                 wr_ptr<=0; rd_ptr<=0;
                 state<=idle;
           end
           else
                 state<=next_state;
     end
     
     //state assignments
     always @(posedge clk)
     begin
           case (state)
                 idle: begin
                              next_state=s0;
                         end
     s0:begin
          if(s_valid & s_ready)
          begin
            if(s_keep==7'd0)
            next_state=s0;
            else if(s_keep==7'd4)
            next_state=s1;
            else if(s_keep==7'd8)
            next_state=s2;
            else if(s_keep==7'd12)
            next_state=s3;
            else if(s_keep==7'd16)
            next_state=s4;
          end
        end
     s1:begin
           if(s_valid & s_ready)
              begin
                if(s_keep==7'd0)
                next_state=s0;
                else if(s_keep==7'd4)
                next_state=s1;
                else if(s_keep==7'd8)
                next_state=s2;
                else if(s_keep==7'd12)
                next_state=s3;
                else if(s_keep==7'd16)
                next_state=s4;
              end
        end
     s2:begin
          if(s_valid & s_ready)
             begin
               if(s_keep==7'd0)
                 next_state=s0;
                 else if(s_keep==7'd4)
                  next_state=s1;
                  else if(s_keep==7'd8)
                  next_state=s2;
                  else if(s_keep==7'd12)
                   next_state=s3;
                   else if(s_keep==7'd16)
                  next_state=s4;
               end
         end
   s3:begin
     if(s_valid & s_ready)
          begin
            if(s_keep==7'd0)
            next_state=s0;
            else if(s_keep==7'd4)
            next_state=s1;
            else if(s_keep==7'd8)
            next_state=s2;
            else if(s_keep==7'd12)
            next_state=s3;
            else if(s_keep==7'd16)
            next_state=s4;
          end 
          end      
    s4:begin
    if(s_valid & s_ready)
              begin
                if(s_keep==7'd0)
                next_state=s0;
                else if(s_keep==7'd4)
                next_state=s1;
                else if(s_keep==7'd8)
                next_state=s2;
                else if(s_keep==7'd12)
                next_state=s3;
                else if(s_keep==7'd16)
                next_state=s4;
              end
       end          
    endcase
    end
     
    //data queuing based on states
    always@(posedge clk)
    begin
    case(next_state)
    s0:begin
        wr_ptr<=0;
       end
    s1:begin
       queue[wr_ptr]<=s_data[3:0];
       wr_ptr<=wr_ptr+1;   
       end
    s2:begin
       queue[wr_ptr]<=s_data[3:0];
       queue[wr_ptr+1]<=s_data[7:4];
       wr_ptr<=wr_ptr+2;
       end
    s3:begin
       queue[wr_ptr]<=s_data[3:0];
       queue[wr_ptr+1]<=s_data[7:4];
       queue[wr_ptr+2]<=s_data[12:8];
       wr_ptr<=wr_ptr+3;
       end
    s4:begin
           queue[wr_ptr]<=s_data[3:0];
           queue[wr_ptr+1]<=s_data[7:4];
           queue[wr_ptr+2]<=s_data[11:8];
           queue[wr_ptr+3]<=s_data[15:12];
           wr_ptr<=wr_ptr+4;
       end
    endcase
    end                                             
    
   
    //register instantiation based on states
    always @(posedge clk)
    begin
         case(next_state)
                s0: r1=0;
                s1: r1=1;
                s2: r1=2;
                s3: r1=3;
                s4: r1=4;
         endcase
    end
    
    //register instantiation for pointer check
    always @(posedge clk)
    begin
          if (s_last==1)
          begin
                r2<=wr_ptr;
                r3<=wr_ptr-r1-1;
                r4<=rd_ptr;
          end
    end
    
    //queue release based on read signals
    always @(posedge clk)
    begin
         if(rd_en & m_ready)
         begin
               if (r2==rd_ptr)
               begin
                     m_data = {{queue[rd_ptr+3]},{queue[rd_ptr+2]},{queue[rd_ptr+1]},{queue[rd_ptr]}};
                     rd_ptr<=rd_ptr+4;
                     m_keep<=8'd16;
                     m_valid<=1'b1;
                     m_last<=1'b1;
                     count<=0;
               end
               else if (r2==rd_ptr+1)
               begin
                     m_data = {{4'd0},{4'd0},{4'd0},{queue[rd_ptr]}};
                     rd_ptr<=rd_ptr+1;
                     m_keep<=8'd4;
                     m_valid<=1'b1;
                     m_last<=1'b1;
                     count<=0;
               end
               else if (r2==rd_ptr+2)
               begin
                     m_data = {{4'd0},{4'd0},{queue[rd_ptr+1]},{queue[rd_ptr]}};
                     rd_ptr<=rd_ptr+2;
                     m_keep<=8'd8;
                     m_valid<=1'b1;
                     m_last<=1'b1;
                     count<=0;
               end
               else if (r2==rd_ptr+3)
               begin
                     m_data = {{4'd0},{queue[rd_ptr+2]},{queue[rd_ptr+1]},{queue[rd_ptr]}};
                     rd_ptr<=rd_ptr+3;
                     m_keep<=8'd12;
                     m_valid<=1'b1;
                     m_last<=1'b1;
                     count<=0;
               end
               else
               begin
                     m_data = {{queue[rd_ptr+3]},{queue[rd_ptr+2]},{queue[rd_ptr+1]},{queue[rd_ptr]}};
                     rd_ptr<=rd_ptr+4;
                     m_keep<=8'd16;
                     m_last<=1'b1;
                     
                     if(count+4==block_length)
                     begin
                          m_data = {{4'd0},{4'd0},{4'd0},{queue[rd_ptr]}};
                          rd_ptr<=rd_ptr+1;
                          m_keep<=8'd4;
                          m_valid<=1'b1;
                          count<=0;
                          last_block<=1'b1;
                     end 
                     else if(count+8==block_length)
                     begin
                          m_data = {{4'd0},{4'd0},{queue[rd_ptr+1]},{queue[rd_ptr]}};
                          rd_ptr<=rd_ptr+2;
                          m_keep<=8'd8;
                          m_valid<=1'b1;
                          count<=0;
                          last_block<=1'b1;
                     end 
                     else if(count+12==block_length)
                     begin
                          m_data = {{4'd0},{queue[rd_ptr+2]},{queue[rd_ptr+1]},{queue[rd_ptr]}};
                          rd_ptr<=rd_ptr+3;
                          m_keep<=8'd12;
                          m_valid<=1'b1;
                          count<=0;
                          last_block<=1'b1;
                     end
                     else if(count<block_length)
                     begin
                          m_data = {{queue[rd_ptr+3]},{queue[rd_ptr+2]},{queue[rd_ptr+1]},{queue[rd_ptr]}};
                          rd_ptr<=rd_ptr+4;
                          m_keep<=8'd16;
                          m_valid<=1'b1;
                          count<=count+16;
                     end
                     if(count<block_length)
                     last_block = 0;
                     else
                     last_block = 1;
               end      
         end
         else
         begin
                m_data=0;
                m_valid=0;
                m_last=0;
                m_keep=0;
                last_block=0;
        end      
    end 
                                                            
endmodule
