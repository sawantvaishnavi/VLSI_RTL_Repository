////////// Method 1 //////////
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



////////// Method 2 //////////
module ring_counter (input clk, clr, output reg [3:0] count);
  
  always@(posedge clk)
    begin
      if (clr) 
        count =  4'b1000;
      else
        count = {count[2:0], count[3]};    
    end
  
endmodule


////////// Method 3 //////////
module ring_counter (input clk, clr, output reg [3:0] count);
  
  always@(posedge clk)
    begin
      if (clr) 
        count <=  4'b1000;
      else begin
       count <= count << 1;
       count[0] <= count[3];
      end
    
    end
  
endmodule

////////// Tb for m2 and m3 //////////
module tb;
  reg clk;
  reg clr;
  wire [3:0] count;
  
  ring_counter dut (clk, clr, count);
  
  initial clk=0;
  always #10 clk = ~clk;
  
  initial begin
   
    clr = 1;
    #20 clr = 0;
  end
  
  initial begin 
    #300 $finish;
  end 
  
  initial begin 
    $dumpfile("dump.vcd");
    $dumpvars(1);
    $monitor (" time= %0t, count=%b",$time,count);
  end
endmodule
