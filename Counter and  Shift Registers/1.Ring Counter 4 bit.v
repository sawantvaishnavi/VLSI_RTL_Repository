module ring_counter (input clk, clr, output reg [3:0]q);
  
  always@(posedge clk) begin
    if(clr==1)
      q <= 4'b1000;
    else
      begin
        q[0] <= q[3];
        q[1] <= q[0];
        q[2] <= q[1];
        q[3] <= q[2];
      end
    end
  
endmodule

//tb
module tb ();
  reg clk;
  reg clr;
  wire [3:0] q;
  
  ring_counter dut (clk, clr, q);
  
  always #10 clk = ~clk;
  
  initial begin
    clk = 0;
    clr = 1;
    #20 clr = 0;
  end
  
  initial begin 
    #300 $finish;
  end 
  
  initial begin 
    $dumpfile("dump.vcd");
    $dumpvars(1);
    $monitor ("clk=%b, clr=%b,q=%b",clk,clr,q);
  end
endmodule
