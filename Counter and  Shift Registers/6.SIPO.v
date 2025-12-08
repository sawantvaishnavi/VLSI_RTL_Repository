module SIPO (input clk, rst, serial_in, output [7:0] parallel_out);
  
  reg [7:0] shift_register;
  
  always@(posedge clk or posedge rst) begin
    if (rst)
      shift_register <= 8'b00000000;
    else
      shift_register <= {shift_register[6:0], serial_in};
  end
  
  assign parallel_out = shift_register ;
  
endmodule



///////////Testbench////////
module tb();
  reg clk;
  reg rst;
  reg serial_in;
  wire [7:0] parallel_out;
  
  SIPO dut (clk, rst, serial_in, parallel_out);
  
  initial begin
    clk = 0;
    rst = 1;
    #11 rst = 0;
  end
  
  always #10 clk = ~clk;
  
  initial begin
      serial_in = 0;
  #15 serial_in = 1;   // from 15
  #20 serial_in = 0;   // till 35 (covers posedge at 30)
end
  
  initial begin 
    #200; 
    $finish;
  end
  
  initial begin
  $monitor("TIME=%0t | rst=%b | serial_in=%b | parallel_out=%b",
           $time, rst, serial_in, parallel_out);
end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
endmodule
