module axi_8bit_reg_tb;

    
    // Signals
    reg clk ;
    reg reset;
    
    reg [7:0] m_data_in;
    reg m_valid;
    reg m_last;
    wire m_ready;

    wire [7:0] s_data_out;
    wire s_valid;
    reg s_ready ;
    wire s_last;

    // Instantiate DUT
    axi_8bit_reg dut (
        .clk(clk),
        .reset(reset),
        .m_data_in(m_data_in),
        .m_valid(m_valid),
        .m_ready(m_ready),
        .m_last(m_last),
        .s_data_out(s_data_out),
        .s_valid(s_valid),
        .s_ready(s_ready),
        .s_last(s_last)
    );
initial
begin
clk =1;
forever #10 clk = ~clk;
end
    
    initial begin
        // Reset
        reset =0;
        #10;
        reset = 1;
        #10;
        reset = 0;
        end
        
        initial
        begin

        // Test data
        m_data_in = 8'h08;
        m_valid =0;
        s_ready = 0;  
        m_last = 0;
    end
    initial
    begin
    #10;
    m_valid = 1; s_ready = 1;
    #100;
    //generate_last_signal(100,10,390);
    s_ready = 0;
    #100;
    m_valid = 0; s_ready =1;
    #100;
    s_ready = 0;
    #100;
    m_valid = 1; s_ready = 1;
    #100
    s_ready = 0;
    end
    
    initial
    begin
    forever #20 m_data_in = $random;
    end
    


  initial
  begin
  repeat (10)
  begin
    m_last = 0;
  #100;
  m_last = 1;
  #11;
  m_last = 0;
  #390;
  m_last = 1;
  #10;
  m_last = 0;
  #390;
  end
  end

endmodule
