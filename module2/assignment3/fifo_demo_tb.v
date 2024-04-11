`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.03.2024 11:24:53
// Design Name: 
// Module Name: fifo_1_tb
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
module fifo_1_ext_tb;

    // Signals
    reg [7:0] data_in;
    reg clk,reset,w_en,r_en;
    wire full, empty;
    wire [3:0]fifo_cnt_1;
    wire [3:0]fifo_cnt_2;
    wire [7:0]data_out_1;
    wire [7:0] final_data;

    // Instantiate DUT
    fifo_1_ext dut (
        .data_in(data_in),
        .clk(clk),
        .rst(reset),
        .r_en(r_en),
        .w_en(w_en),
        .empty(empty),
        .data_out_1(data_out_1),
        .full(full),
        .fifo_cnt_1(fifo_cnt_1),
        .fifo_cnt_2(fifo_cnt_2),
        .final_data(final_data)
    );
 
   
// Clock Generation
 initial 
    begin
        clk = 0;
        forever #10 clk = ~clk;
    end
     
//reset
initial begin
      reset = 1'b0;
     @(posedge clk) reset = 1'b1;
     @(posedge clk) reset = 1'b0;
end
   
initial begin
    @(posedge clk)data_in = 8'h00;
    repeat (100)
     @(posedge clk) data_in = $random;
 end
     
initial begin
    w_en = 1'b0;
    r_en = 1'b0;
    repeat(20)@(posedge clk)
        w_en = 1'b1;
    repeat(5)@(posedge clk)
        w_en = 1'b1;
        r_en = 1'b1;
    repeat(15)@(posedge clk)
        w_en = 1'b0;
        r_en = 1'b1;
    repeat(15)@(posedge clk)
        w_en = 1'b1;
        r_en = 1'b0;
end

 /*initial 
     begin
           w_en = 1;        r_en = 0;
       #100 w_en = 1;        r_en = 1;
       #50 w_en =1;         r_en=1;
       #80 w_en = 1;        r_en = 0;
       #150 w_en = 1;        r_en = 0;
       #150 w_en = 0;        r_en = 1;
       #100 w_en = 0;        r_en = 1;
       
     end
*/
endmodule
