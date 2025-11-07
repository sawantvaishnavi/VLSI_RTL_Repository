//Normal counter
module counter (input clk, rst, output  reg [3:0] count) ;
 
  initial count =0; 
  always@(posedge clk) begin
    
    if (rst)
      count <= 0;
    else
      count <= count + 1;
  end
endmodule


module tb ();
  
  reg clk;
  reg rst;
  wire [3:0] count;
    
  counter dut (clk, rst, count);
   
  initial begin
    rst = 1;
    clk = 0;
    #10 rst = 0;
  end
  
  always #10 clk = ~clk; 
  
  initial begin
   $monitor("Count = %0d", count);
  end
  
  initial begin
    #400 $finish;
  end
endmodule
