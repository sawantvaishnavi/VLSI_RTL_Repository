module full_adder (input in1, in2, in3, output sum, carry);
  
  assign sum = in1 ^ in2 ^ in3;
  assign carry = (in1 & in2) | (in2 & in3) | (in1 & in3);
endmodule

//testbench
module tb;
  reg in1;
  reg in2;
  reg in3;
  wire sum;
  wire carry;
  
  full_adder dut (in1,
                 in2,
                 in3,
                 sum,
                 carry);
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1);
    
    /* Place $monitor before input changes, otherwise updates may finish before it starts printing */

    $monitor ("in1=%b, in2=%b, in3=%b, sum=%b, carry=%b", in1, in2, in3, sum, carry);
    
    for (int i = 0; i < 8; i = i + 1) begin
      {in1, in2, in3} = i;
      #10;
    end
  end

endmodule

