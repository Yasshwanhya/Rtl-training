`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.03.2024 12:34:18
// Design Name: 
// Module Name: mux_axi
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


module mux_axi (
    input              clk,
    input              reset,

    // Master 1 input
    input      [7:0]   m1_data_in,
    input              m1_valid,
    output       reg      m1_ready,
    input              m1_last,

    // Master 2 input
    input      [7:0]   m2_data_in,
    input              m2_valid,
    output     reg        m2_ready,
    input              m2_last,

    // Mux control inputs
    input              select,  // Select data from Master 

    // Slave output
    output reg [7:0]   s_data_out,
    output  reg           s_valid,
    input              s_ready,
    output    reg         s_last
);

    // Internal registers to store data from each master
    reg [7:0]data_reg;
//    reg m1_valid_reg;
//    reg m1_last_reg;
    
////    reg [7:0] m2_data_reg;
//    reg m2_valid_reg;
//    reg m2_last_reg;

    always @(negedge clk) begin
        if (reset==1) begin
            // Reset internal registers
            data_reg <= 8'b0;
//            m1_valid_reg <= 1'b0;
//            m1_last_reg <= 1'b0;

////            m2_data_reg <= 8'b0;
//            m2_valid_reg <= 1'b0;
//            m2_last_reg <= 1'b0;
        end 
        else 
        begin
            // Update internal registers with data from Master 1
            if(select == 0)
            begin
            if (m1_valid && s_ready ) 
            begin
                data_reg <= m1_data_in;
            end
            else
            begin
               data_reg<=data_reg;
            end
            end

            // Update internal registers with data from Master 2
             if(select == 1)
            begin
            if (m2_valid && s_ready ) 
            begin
                data_reg <= m2_data_in;
            end
            else
            begin
               data_reg<=data_reg;
            end
            end
            
           
        end
        
           
            
        
    end

    always @(negedge clk) begin
        if (reset)
        begin
        s_data_out<=8'h00;
        s_last<=0;
        s_valid<=0;
        m1_ready<=0;
        m2_ready<=0;
        end
        else
        begin
        
        s_data_out <= data_reg;
        s_last <= select ? m2_last : m1_last ;
        s_valid <= select ? m2_valid : m1_valid;
        m1_ready <= select ? 0 : s_ready;
        m2_ready <= select ? s_ready : 0;
        end
    end

endmodule
