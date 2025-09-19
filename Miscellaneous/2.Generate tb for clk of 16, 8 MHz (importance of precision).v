// Importance to understand timescale directive with time unit and time precision relation
// 16 MHZ -->> Time period = 65.5nsec -->> Half Time Period = 31.25 nsec
// 8MHz -->> Time period = 125 nsec  -->>  Half Time Period = 65.5 nsec

`timescale 1ns / 1ps   //10^3 -> 3
 
module tb();
 
  reg clk16 = 0;
  reg clk8 = 0;  ///initialize variable
  
 
   always #31.25 clk16 = ~clk16;
   always #62.5 clk8 = ~clk8;
  
 
 
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
 
 
  initial begin
    #200;
    $finish();
  end
  
endmodule
