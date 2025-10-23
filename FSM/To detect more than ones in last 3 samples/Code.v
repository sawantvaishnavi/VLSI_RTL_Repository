//===================================================
//Design
//===================================================
module fsm (input clk, rst ,in, output reg y);
  parameter s0=2'b00, s1=2'b01, s2=2'b10, s3=2'b11;
  reg [1:0] pstate , nstate;
  
  
  //Sequential Section
  //State info is latched into state register
  always@(posedge clk)begin
    if(rst)
      pstate <= s0;
    else
      pstate <= nstate;
  end
  
  //Combinational Section
  //Next state is determine using this
  always@(in, pstate)
    begin
      case(pstate)
        s0: nstate = in?s1:s0;
        s1: nstate = in?s2:s3;
        s2: nstate = in?s2:s3;
        s3: nstate = in?s1:s0;
        default: nstate = s0;
      endcase
    end
  
  //Output Logic
  always@(in, pstate) begin
    case(pstate)
      s0: y = 0;
      s1: y = in?1:0;
      s2: y = 1;
      s3: y = 0;
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
  
  // Instantiate DUT
  fsm dut (.clk(clk), .rst(rst), .in(in), .y(y));
  
  // Clock Generation
  initial begin
    clk = 0;
    forever #10 clk = ~clk;   // 20 ns clock period
  end
  
  // Stimulus
  initial begin
    rst = 1; in = 0;
    #12 rst = 0;
    
    // Apply input sequence: 1 0 1 1 1 1
    #10 in = 1;
    #10 in = 0;
    #10 in = 1;   // expect y=1
    #10 in = 1;
    #10 in = 1;
    #10 in = 1;   // expect y=1
    #20 $finish;
  end
  
  // Monitor signals dynamically
  initial begin
    $monitor("Time=%0t | rst=%b | in=%b | state=%b | y=%b",
              $time, rst, in, dut.pstate, y);
  end
endmodule
