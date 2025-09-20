module full_subtractor (input in1, in2, in3, output diff, borrow);
  
  assign diff = in1 ^ in2 ^ in3;
  assign borrow = (~in1 & in2) | (~in1 & in3) | (in2 & in3);
endmodule


//Testbench
module tb;
  reg in1;
  reg in2;
  reg in3;
  wire diff;
  wire borrow;
  
  full_subtractor dut (in1,
                 in2,
                 in3,      
                 diff,
                 borrow);
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1);
    
    /* Place $monitor before input changes, otherwise updates may finish before it starts printing */

    $monitor ("in1=%b, in2=%b, in3=%b, diff=%b, borrow=%b", in1, in2, in3, diff, borrow);
    
    for (int i = 0; i < 8; i = i + 1) begin
      {in1, in2, in3} = i;
      #10;
    end
  end

endmodule
