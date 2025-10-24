//===================================================
//Design
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

//===================================================
// Testbench
//===================================================
module tb;
  reg clk, rst, in;
  wire y;

  div_by_5 dut (clk, rst, in, y);

  // Clock generation
  initial begin
    clk = 0;
    forever #10 clk = ~clk;   // 20ns period
  end

  // Stimulus
  initial begin
    rst = 0; in = 0;
    #5 rst = 1;   // release reset before next posedge clk

    // Apply bits '1', '0', '1' — aligned between clock edges
    #15 in = 1;   // set input after posedge (safe zone)
    #20 in = 0;
    #15 in = 1;
    #40 $finish;
  end

  // Monitor outputs
  initial begin
    $monitor("Time=%0t clk=%b in=%b y=%b pstate=%b",
              $time, clk, in, y, dut.pstate);
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars();
  end
endmodule
