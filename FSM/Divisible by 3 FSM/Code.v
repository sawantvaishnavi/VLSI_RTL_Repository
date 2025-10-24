//===================================================
//Design
//===================================================
module div_by_3 (input clk, rst, in, output reg y);
  
  parameter s0=2'b00, s1=2'b01, s2=2'b10;
  
  reg [1:0] pstate, nstate;
  
  //sequential logic
  always@(posedge clk) begin
    if(!rst)
      pstate <= s0;
    else
      pstate <= nstate;
  end
  
  //combinational logic
  //moore circuit
  always@(pstate, in) begin
    case(pstate)
      s0: nstate = in?s1:s0;
      s1: nstate = in?s0:s2;
      s2: nstate = in?s2:s1;
      default: nstate= s0;
    endcase
  end
  
  //output logic
  always@(pstate) begin
    case(pstate)
      s0: y = 1;
     default: y = 0;
    endcase
  end
  
endmodule


//===================================================
// Testbench
//===================================================
module tb;
  reg clk, rst, in;
  wire y;

  div_by_3 dut (.clk(clk), .rst(rst), .in(in), .y(y));

  // Clock generation
  initial begin
    clk = 0;
    forever #10 clk = ~clk;   // 20 ns period
  end

  // Stimulus
  initial begin
    rst = 0; in = 0;
    #5 rst = 1;               // release reset before first posedge

    // Apply bits '1', '1', '0' (binary 110 = decimal 6)
    // Each bit held for one full clock period
    #15 in = 1;               // first bit (MSB)
    #20 in = 1;               // second bit
    #20 in = 0;               // third bit (LSB)
    #30 $finish;
  end

  // Monitor
  initial begin
    $monitor("Time=%0t clk=%b in=%b y=%b pstate=%b",
             $time, clk, in, y, dut.pstate);
  end

  // Dump VCD for waveform view
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars();
  end
endmodule

