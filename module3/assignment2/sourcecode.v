`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.05.2024 10:21:10
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


module assign2 #(
    parameter Data_width = 8,  // Data width is 8 bits (1 byte)
    parameter Depth = 10     // Depth of the storage
)(
    input clk,
    input rst,
    
    // AXI Stream Slave Interface
    input [Data_width-1:0] s_data,
    input s_valid,
    input s_last,
    output reg s_ready,

    // Configuration input
    input [Data_width-1:0] k,  // Configuration for packet processing
    input [Data_width-1:0] len,// Length of the packet

    // AXI Stream Master Interface
    output reg [Data_width-1:0] m_data,
    output reg m_valid,
    output reg m_last,
    input m_ready,

    // Status signals
    output full,
    output empty
);
    integer i;
    reg [Data_width-1:0] data [Depth-1:0];  // Storage for incoming data
    reg valid [Depth-1:0];                  // Valid signal storage
    reg last [Depth-1:0];                   // Last signal storage
    reg [Data_width-1:0] wr_ptr1;               // Write pointer for incoming data
    reg [Data_width-1:0] rd_ptr;                // Read pointer for outgoing data
    reg [Data_width-1:0] wr_ptr2;               // Write pointer for processing

    initial 
    begin
        for(i = 0; i < Depth; i = i + 1) 
        begin
            data[i] = 0;
            valid[i] = 0;
            last[i] = 0;
        end
    end

    // Slave ready signal
    always @(posedge clk)
    begin
        if (rst)
            s_ready <= 0;
        else
            s_ready <= 1;
    end

    assign full = (wr_ptr1 == Depth) ? 1 : 0;
    assign empty = (wr_ptr2 == 0) ? 1 : 0;

    // Data storage and processing
    always @(posedge clk) begin
        if (rst) begin
            wr_ptr1 <= 0;
            wr_ptr2 <= 0;
        end 
        else if (s_valid && s_ready) 
        begin
            data[wr_ptr1] <= s_data;
            valid[wr_ptr1] <= 1;
            last[wr_ptr1] <= s_last;

            if (wr_ptr1 == len - 1 || s_last) 
            begin
                wr_ptr1 <= 0;
                wr_ptr2 <= len - k;
            end 
            else 
            begin
                wr_ptr1 <= wr_ptr1 + 1;
            end

            if (wr_ptr2 != 0) 
            begin
                data[wr_ptr2] <= data[wr_ptr2] + s_data;
                valid[wr_ptr2] <= (s_data == 0) ? 1'b0 : 1'b1;

                if (wr_ptr2 == len - 1) 
                begin
                    wr_ptr2 <= 0;
                end 
                else 
                begin
                    wr_ptr2 <= wr_ptr2 + 1;
                end
            end
        end
    end

    // Data retrieval and output
    always @(posedge clk) 
    begin
        if (rst) 
        begin
            rd_ptr <= -(k + 2);
            m_valid <= 0;
            m_last <= 0;
            m_data <= 0;
        end 
        else if (m_ready) 
        begin
            if (rd_ptr >= 0 && rd_ptr < len)
            begin
                m_valid <= valid[rd_ptr];
                m_last <= last[rd_ptr];
                m_data <= data[rd_ptr];
            end 
            else 
            begin
                m_valid <= 0;
                m_last <= 0;
                m_data <= 0;
            end

            if (rd_ptr == len - 1) 
            begin
                rd_ptr <= 0;
            end 
            else 
            begin
                rd_ptr <= rd_ptr + 1;
            end
        end
        else 
        begin
            m_valid <= 0;
            m_last <= 0;
            m_data <= 0;
        end
    end

endmodule
