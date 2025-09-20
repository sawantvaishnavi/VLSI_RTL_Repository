module mod_10_counter (input resetn, clk, output reg [3:0]out);
 
  always @(posedge clk or negedge resetn) begin
    if (!resetn)
      out <= 0;
    else begin 
      if (out == 10)
        out <= 0;
      else
        out <= out + 1;
    end
 end
endmodule


//tb
module tb ();
  reg resetn;
  reg clk;
  wire [3:0] out;
  
  mod_10_counter dut (resetn, clk, out);
  
  initial begin
    resetn =0;
    clk= 0;
    #10 resetn =1;
  end
  
  always #10 clk = ~clk;
  
  initial begin 
     $dumpfile ("dump.vcd");
    $dumpvars(1);
    
    $monitor ("out= %d",out);
  end
  
initial begin
  #300 $finish;
end
  
endmodule
