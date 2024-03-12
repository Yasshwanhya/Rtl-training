module axi_8bit_reg (
    input              clk,
    input              reset,
    
    // Master input
    input      [7:0]   m_data_in,
    input              m_valid,
    output  reg      m_ready,
    input              m_last,
    
    // Slave output
    output  reg [7:0]   s_data_out,
    output   reg          s_valid,
    input              s_ready,
    output  reg      s_last
);

     //Internal registers
    reg [7:0] data_out;
    reg        valid;
    reg ready;
    reg last;
    
    // AXI stream register logic
    always @(negedge clk) begin
        if (reset) begin
            data_out <= 8'b0;
            valid <= 1'b0;
            last <= 1'b0;
        end else begin
            if (m_valid && s_ready) begin
               data_out <= m_data_in;
              valid  <= 1'b1;
              ready<=s_ready;
              last<=m_last;
            end else 
            begin
           if (m_valid)
           begin
               data_out<= data_out;
                valid <= 1'b1;
              ready<=s_ready;
              last <= m_last;
              end
              else
              begin
              data_out<= data_out;
                valid <= 1'b0;
              ready<=s_ready;
              last<=m_last;
              end
        end
    end
end
 
always @(negedge clk) 
 begin
if(reset)
 s_data_out <= 8'h0;
  else
  begin  
            s_data_out <= data_out;
            s_valid <= valid;
            m_ready<=ready;
            s_last<= m_last;
     end   
        
 end   
 
    // Output assignment
//  always @(negedge clk)
//  begin
//   s_last <= m_last;
//  end 
    

endmodule
