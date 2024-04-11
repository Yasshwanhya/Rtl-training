`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.03.2024 11:24:53
// Design Name: 
// Module Name: fifo_1
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
///////////////////////////////////////////////////////////
module fifo_1 (
input [7:0] data_in,
 input clk, rst, rd, wr,
output  empty,
output  full,
output reg [3:0]fifo_cnt,
output reg [7:0] data_out);


reg [7:0] fifo [0:7];
reg [2:0] rd_ptr;
reg [2:0] wr_ptr;

always @(negedge clk)
begin
    if (rst) 
    begin
        wr_ptr <= 0;
        rd_ptr <= 0;
    end
    else
    begin: write
         if (wr && ~full)  
         begin
            fifo [wr_ptr] <= data_in;
             wr_ptr <=  wr_ptr+1;
         end
         //read
         if (rd && ~empty)
            begin
                data_out <= fifo [rd_ptr];
                rd_ptr <=  rd_ptr+1 ;
            end
         end
end

//counter
always @(negedge clk) begin: count
    if (rst) fifo_cnt <= 0;
    else begin
        case ({wr, rd})
            2'b00: fifo_cnt <= fifo_cnt;
            2'b01: fifo_cnt <= (fifo_cnt==0) ? 0: fifo_cnt-1;
            2'b10: fifo_cnt <= (fifo_cnt==8) ? 8: fifo_cnt+1;
            2'b11 : fifo_cnt <= fifo_cnt;
            default: fifo_cnt <= fifo_cnt;
        endcase
    end
end

assign empty = (fifo_cnt ==0)?1:0;
assign full = (fifo_cnt ==8)?1:0;

endmodule


module fifo_1_ext( 
        input [7:0] data_in,
        input clk,rst,w_en,r_en,
        output [7:0] final_data,
        output reg full, empty,
        output [7:0]data_out_1,
        output  [3:0]fifo_cnt_1,
        output  [3:0]fifo_cnt_2
             );
             
wire f1,f2,e1,e2;
reg w1,w2,r1,r2;
//wire [7:0]data_out_1;




always@(posedge clk) begin
    if (rst) begin
        r1 <= 1'b0;
        w1 <= 1'b0;
        r2 <= 1'b0;
        w2 <= 1'b0;
    end 
    else begin
        r1 = (~e1 && r_en) ? 1'b1 : 1'b0;
        w1 = (~f1 && w_en) ? 1'b1 : 1'b0;
        r2 = (e1 && ~e2 && r_en) ? 1'b1 : 1'b0 ;
        w2 = (f1 && ~f2 && w_en) ? 1'b1 : 1'b0 ; 
    end
end


fifo_1 FIFO_1( data_in, clk, rst, r1, w1, e1, f1,fifo_cnt_1, data_out_1);

fifo_1 FIFO_2(data_in, clk, rst, r2, w2 , e2, f2,fifo_cnt_2, final_data);

always @(posedge clk,posedge rst) begin
    if (rst) begin
        full <= 1'b0;
        empty <= 1'b1;
    end else begin
        full <= f1 && f2;
        empty <= e1 && e2;
    end
end
endmodule
