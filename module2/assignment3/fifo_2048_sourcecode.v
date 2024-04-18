`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.04.2024 12:00:02
// Design Name: 
// Module Name: fifo_2048
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


module fifo_2048#(
parameter DataWidth = 16,
    parameter Depth = 2048,
    parameter PtrWidth = $clog2(Depth),
    parameter MAX_VALUE = (2**PtrWidth) - 1
)(
    input [DataWidth-1:0] data_in,
    input clk, rst, 
    input rd, wr,
    output empty,
    output full,
    
    
    output reg [DataWidth-1:0] data_out
);
 reg [PtrWidth+1:0] fifo_cnt;
    reg [PtrWidth-1:0] rd_ptr;
    reg [PtrWidth-1:0] wr_ptr;
    reg [DataWidth-1:0] fifo [0:Depth-1];

    always @(negedge clk) begin
        if (rst) begin
            wr_ptr <= 0;
            rd_ptr <= 0;
        end else begin
            // Write operation
            if (wr && ~full) begin
                fifo[wr_ptr] <= data_in;
                wr_ptr <= wr_ptr + 1;
            end
            // Read operation
            if (rd && ~empty) begin
                data_out <= fifo[rd_ptr];
                rd_ptr <= rd_ptr + 1;
            end
        end
    end

    // Counter
    always @(negedge clk) begin
        if (rst) begin
            fifo_cnt <= 0;
        end else begin
            case ({wr, rd})
                2'b00: fifo_cnt <= fifo_cnt;
                2'b01: fifo_cnt <= (fifo_cnt == 0) ? 0 : fifo_cnt - 1;
                2'b10: fifo_cnt <= (fifo_cnt == MAX_VALUE) ? MAX_VALUE : fifo_cnt + 1;
                2'b11: fifo_cnt <= fifo_cnt;
                default: fifo_cnt <= fifo_cnt;
            endcase
        end
    end

    assign empty = (fifo_cnt == 0) ? 1 : 0;
    assign full = (fifo_cnt == MAX_VALUE) ? 1 : 0;

endmodule




