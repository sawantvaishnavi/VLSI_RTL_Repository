//Half Adder is combinational logic design

module half_adder (input in1, in2, output sum, carry);
  
  assign carry = in1 & in2;
  assign sum = in1 ^ in2;
  
endmodule


//testbench
module tb;
  reg in1;
  reg in2;
  wire sum;
  wire carry;
  
  half_adder dut (in1,
                 in2,
                 sum,
                 carry);
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1);
    
    /* Place $monitor before input changes, otherwise updates may finish before it starts printing */

    $monitor ("in1=%b, in2=%b, sum=%b, carry=%b", in1, in2, sum, carry);
    
    for (int i = 0; i < 4; i = i + 1) begin
      {in1, in2} = i;
      #10;
    end
  end

endmodule
