`timescale 1ns / 1ps

module axi_8bit(
    input clk,rst,
    
    //slave
    input [7:0]s_data,
    input s_valid,
    output reg s_ready,
    input  s_last,
    
    //master
    output reg [7:0]m_data,
    output reg m_valid,
    input m_ready,
    output  m_last
     );
reg [7:0]data;
reg valid;
reg ready;
reg last;

always@(posedge clk) begin
    valid <= s_valid;
    ready <= m_ready;

end

always@(negedge clk or negedge rst) begin
    if(rst) begin
        data <= 0;
        valid <= 0;
        ready <= 0;
//        last <=0;   
    end
    else begin
     if(s_valid && m_ready) data <= s_data;
     else data <=0;
    end
end

always @(negedge clk)
begin
    if(rst) 
    begin
        m_data <= 0;
        m_valid <= 0;
        s_ready <= 0;
//        m_last <=0;   
    end
    else
    begin
       s_ready <= ready;
       m_data <= data;
//       m_last <= last;
       m_valid <= valid;
    end
end
always@(negedge clk)
begin
    last <= s_last;
    end
assign m_last = last;
endmodule
