module sr_latch (input s, r, output reg q, qbar);
  always@(s, r) begin
    
    if (s && !r) begin
      q    <= 1;
      qbar <= 0;
    end
    else if (!s && r) begin
      q	   <= 0;
      qbar <= 1;
    end
    else if (!s && !r) begin
      //hold
    end
    else begin
      q	   <= 1'bx;
      qbar <= 1'bx;
    end
  end
  
endmodule


module tb();
  
  reg s;
  reg r;
  wire q;
  wire qbar;
  
  sr_latch dut  (s, r, q, qbar);
  
  initial begin
    
    s=1; r=0;
    #10;
    s=0; r=0;
    #10;
    s=0; r=1;
    #10;
    s=1; r=1;
    #10;
    $finish;
  end
  initial begin
    $monitor("Time=%0t | S=%0b |  R=%0b | Q=%0b | Qbar=%0b", $time, s, r, q, qbar);
  end
endmodule
