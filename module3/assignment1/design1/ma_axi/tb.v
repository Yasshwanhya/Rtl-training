`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.05.2024 07:12:50
// Design Name: 
// Module Name: design_1_ma_axi_tb
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


module design_1_ma_axi_tb();
parameter DW=8;


reg clk;
reg reset;

//slave data A
reg [DW-1:0]A;
reg a_valid;
wire a_ready;
    
//slave data B
reg [DW-1:0]B;
reg b_valid;
wire b_ready;
    
//slave data C
reg [DW-1:0]C;
reg c_valid;
wire c_ready;


    
    //master 
wire [DW-1:0]m_data;
wire m_valid;
reg m_ready;

design_1_ma_axi DUT(.clk(clk),.reset(reset),.A(A),.a_valid(a_valid),
            .a_ready(a_ready),.B(B),.b_valid(b_valid),.b_ready(b_ready),
            .C(C),.c_valid(c_valid),.c_ready(c_ready),.m_data(m_data),
            .m_valid(m_valid),.m_ready(m_ready));

// Clock Generation
initial begin
    clk = 1;
    forever #10 clk = ~clk;
end
     
//reset
initial begin
    reset = 1'b1;
    #40;reset = 1'b0;
end

initial begin
    A='d0;
    B='d0;
    C='d0;

    repeat(3)@(posedge clk);
    repeat(1000) begin
        A = A + 1 ;
        B = B + 2 ;
        C = C + 3 ;
        
       @(posedge clk);
       @(posedge clk);
    end
    A= 'd0;
    B= 'd0;
    C= 'd0;
   
end

initial begin
    /*repeat(5)@(posedge clk) a_valid = 1'b1;
    repeat(5)@(posedge clk) a_valid = 1'b0;
    repeat(10)@(posedge clk) a_valid = 1'b1;
    repeat(5)@(posedge clk) a_valid = 1'b0;*/
    a_valid = 1'b0;
    repeat(2)@(posedge clk);
    repeat(21)@(posedge clk) a_valid = 1'b1;
    repeat(2)@(posedge clk);
    repeat(21)@(posedge clk) a_valid = 1'b0;
    repeat(2)@(posedge clk);
    repeat(21)@(posedge clk) a_valid = 1'b1;
    
    a_valid = 1'b0;
end

initial begin
    /*repeat(5)@(posedge clk) b_valid = 1'b1;
    repeat(5)@(posedge clk) b_valid = 1'b0;
    repeat(10)@(posedge clk) b_valid = 1'b1;
    repeat(5)@(posedge clk) b_valid = 1'b0;*/
    b_valid = 1'b0;
    repeat(2)@(posedge clk);
    repeat(21)@(posedge clk) b_valid = 1'b1;
    repeat(2)@(posedge clk);
    repeat(21)@(posedge clk) b_valid = 1'b0;
    repeat(2)@(posedge clk);
    repeat(21)@(posedge clk) b_valid = 1'b1;
    
    b_valid = 1'b0;
end


initial begin
    /*repeat(5)@(posedge clk) c_valid = 1'b1;
    repeat(5)@(posedge clk) c_valid = 1'b0;
    repeat(10)@(posedge clk) c_valid = 1'b1;
    repeat(5)@(posedge clk) c_valid = 1'b0;*/
    c_valid = 1'b0;
    repeat(2)@(posedge clk);
    repeat(21)@(posedge clk) c_valid = 1'b1;
    repeat(2)@(posedge clk);
    repeat(21)@(posedge clk) c_valid = 1'b1;
    repeat(2)@(posedge clk);
    repeat(21)@(posedge clk) c_valid = 1'b1;
    c_valid = 1'b0;
end
initial begin
    m_ready = 1'b1;
    
end

endmodule
