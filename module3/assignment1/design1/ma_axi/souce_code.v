`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.05.2024 07:13:17
// Design Name: 
// Module Name: design_1_ma_axi
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

module design_1_ma_axi#(parameter Data_width=16)(
    input clk,
    input reset,
    // slave data A
    input [Data_width-1:0]A, // data
    input a_valid,
    output a_ready,
    
    //slave data B
    input [Data_width-1:0]B,
    input b_valid,
    output b_ready,
    
    //slave data C
    input [Data_width-1:0]C,
    input c_valid,
    output c_ready,
    
    //master 
    output [Data_width-1:0]m_data,
    output reg m_valid,
    input m_ready
    );
    
    // registers used for the pipelining
    reg [Data_width-1:0]A0='d0;
    reg [Data_width-1:0]B0='d0;
    reg [Data_width-1:0]C0='d0;
    reg [Data_width-1:0]out_0='d0;
    
    reg [Data_width-1:0]A1='d0;
    reg [Data_width-1:0]B1='d0;
    reg [Data_width-1:0]C1='d0;
    reg [Data_width-1:0]out_1='d0;
    
    reg valid_1;
    reg valid_2;

    
    assign a_ready = a_valid & m_ready;
    assign b_ready = b_valid & m_ready;
    assign c_ready = c_valid & m_ready; 
    
    always@(posedge clk) begin
        if(reset)begin
            A0 <= 'd0;
            B0 <= 'd0;
            C0 <= 'd0;

            A1 <= 'd0;
            B1 <= 'd0;
            C1 <= 'd0;

            out_0 <= 'b0;
            out_1 <= 'b0;
            
            valid_1 <= 'b0;
            valid_2 <= 'b0;
 
            m_valid <= 'b0;
        end
        else if(a_valid && b_valid && c_valid && m_ready) begin
                               
                A0 <= A;
                B0 <= B;
                C0 <= C;
                                              
                A1 <= A0;
                B1 <= B0;
                C1 <= C0;
                       
                out_0<= ( ($signed(A1)* $signed(B1))+($signed(C1)));      
                out_1 <= out_0;
                valid_1 <= a_valid & b_valid & c_valid;        
                valid_2 <= valid_1;
                m_valid <= valid_2;
        end
        else begin 
                A0 <= 0;
                A1 <= 0;
        
                B0 <= 0;
                B1 <= 0;
                
                C0 <= 0;
                C1 <= 0;
                

                
                out_0 <= 0;
                out_1 <= 0;
        
                valid_1<=0;
                valid_2<=0;
                m_valid<=0;
        end
end

assign m_data = out_1;
    
endmodule
