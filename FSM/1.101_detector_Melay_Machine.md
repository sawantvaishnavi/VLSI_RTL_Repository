//In melay ckt y goes high without waiting for the clock to actually move to s1.

module seq_101_dect_ov_melay (input in, clk, rst, output reg y);

  parameter s0=2'b00, s1=2'b01, s2=2'b10;
  
  reg [1:0] pstate, nstate;
  
  always@(posedge clk) begin
    if(rst)
      pstate <= s0;
    else
      pstate<= nstate;
  end
  
  always@(in, pstate) begin
    case (pstate)
      s0: 
        begin
        		nstate = in?s1:s0;
        		y = 0;
        end
      
      s1:
        begin
          		nstate = in?s1:s2;
          		y = 0;
        end
      
      s2:
        begin
          		nstate = in?s1:s0;
          		y = in?1:0;
        end
      
      default:
        begin
          		nstate = 0;
          		y = 0;
        end
    
      endcase
    
  end
endmodule



//tb
module tb;
  reg clk, rst, in;
  wire y;

  seq_101_dect_ov_melay dut (in , clk, rst, y);

  // clock gen
  initial begin
    clk = 0;
    forever #5 clk = ~clk;  // 100 MHz
  end

  // stimulus
  initial begin
    rst = 1; in = 0;
    #12 rst = 0;

    // Apply input sequence: 101101
   #10 in = 1;
   #10 in = 0; 
   #10 in = 1;   // detect → y=1

   #10 in = 1; 
   #10 in = 0;
   #10 in = 1;    // detect → y=1 again

   #10 in = 0; 
   #10 in = 1; 
    $monitor("in= %0d, y= %0d", in,y);

    #50 $finish;
  end

  // waveform dump
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb);
  end
endmodule

