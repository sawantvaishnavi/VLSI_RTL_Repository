module freq_divide_by_4 (
    input  clk,
    input  rst,      // active-high reset
  output reg [1:0] count,
  output fby4
);
  
  

always @(posedge clk) begin
   
  if (rst)
    count <= 2'b0;
  else
    count <= count + 1;
     
end

  assign fby4 = count[1];
endmodule


//////// TB ////////
module tb;

  reg clk;
  reg rst;
  wire [1:0]count;
  wire fby4;
  
  freq_divide_by_4  dut ( clk,rst, count, fby4);
  
  initial clk = 0;
  always #10 clk = ~clk;
  
  initial begin
    rst =1;
    #25 rst= 0;
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars ();
  end
  initial begin
    #200;
    $finish;
  end
endmodule
  

