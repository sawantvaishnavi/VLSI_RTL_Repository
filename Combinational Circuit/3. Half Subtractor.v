//Half Adder is combinational logic design
module half_subtractor (input in1, in2, output diff, borrow);
    
  assign diff = in1 ^ in2;
  assign borrow = ~in1 & in2;
  
endmodule


//Testbench
module tb;
  reg in1;
  reg in2;
  wire diff;
  wire borrow;
  
  half_subtractor dut (in1,
                 in2,
                 diff,
                 borrow);
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1);
    
    /* Place $monitor before input changes, otherwise updates may finish before it starts printing */

    $monitor ("in1=%b, in2=%b, diff=%b, borrow=%b", in1, in2, diff, borrow);
    
    for (int i = 0; i < 4; i = i + 1) begin
      {in1, in2} = i;
      #10;
    end
  end

endmodule
