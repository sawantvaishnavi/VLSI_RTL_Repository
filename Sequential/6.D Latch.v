module d_latch (input d, en, output reg q);
  
  always@(d or en) begin
    if (en)
      q <= d;
    else
      q	<= 1'b0;
  end
endmodule


module tb();
  reg d;
  reg en;
  wire q;
  
  d_latch dut (d, en, q);
  
  initial begin
    repeat(5) begin
      d = $urandom_range(0,1);
      en = $urandom_range(0, 1);
      #10;  //Delay is given bez: T+delta time we are giving so values is updating properly
      $display("TIME= %0t \t D=%0b \t EN=%0b \t Q=%0b", $time, d, en, q);
      
    end
    
  end
endmodule
