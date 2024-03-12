
module mux_axi_tb;

reg clk;
reg reset;
// Master 1 input

wire m1_ready;


// Master 2 input

wire m2_ready;

 // Mux control inputs

// Slave output
reg m1_valid;
reg s_ready;
reg m1_last;
reg m2_valid;
reg s_ready;
reg m2_last;
reg select;  // Select data from Master 
reg [7:0]   m1_data_in;
reg [7:0]   m2_data_in;
wire [7:0]   s_data_out;
wire s_valid;

wire s_last;

mux_axi  m1 (clk, reset, m1_data_in, m1_valid, m1_ready, m1_last, m2_data_in, m2_valid,m2_ready, m2_last, select, s_data_out, s_valid, s_ready, s_last);

initial
begin
    clk = 1;
    forever #10 clk = ~clk;
end

initial
begin
    reset = 0;
    #100;
    reset = 1;
    #50;
    reset = 0;
end

initial
begin
     m1_data_in = 8'h3e ;
     m2_data_in = 8'h4f ;
end

initial
begin
     select = 0;
     forever #50 select = ~select;
end

initial
begin
     m1_valid=0;
     forever #60 m1_valid = ~m1_valid;
end

initial
begin
     m2_valid=0;
     forever #70 m2_valid = ~m2_valid;
end

initial
begin
repeat(10)
begin
    m1_last = 0;
    #70;
    m1_last = 1;
    #10;
    m1_last = 0;
    #150;
    m1_last = 1;
    #10;
end    
end

initial
begin
repeat(10)
begin
m2_last = 0;
#70;
m2_last = 1;
#10;
m2_last = 0;
#50;
m2_last = 1;
#10;
m2_last = 0;
#90;
m2_last = 1;
#10;
m2_last = 0;
#150;
m2_last = 1;
#10;
m2_last = 0;
#150;
m2_last = 1;
#10;
end
end

initial
begin
    s_ready = 0;
    forever #40 s_ready = ~s_ready;
end



endmodule
