module mux2x1 (input i0, i1, sel, output out);
  
  assign out = sel? i1 : i0;

endmodule


//Tb
module tb;
  wire out;
  reg i0;
  reg i1;
  reg sel;
  
  mux2x1 dut (i0,
             i1,
             sel,
             out);
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1);
    
    $monitor ("i0=%b, i1=%b, sel=%b, out=%b", i0, i1, sel, out);
    
    for (int i = 0; i < 8; i = i + 1) begin
    {i0, i1, sel} = i;
    #10;
    end
  end
    
endmodule
