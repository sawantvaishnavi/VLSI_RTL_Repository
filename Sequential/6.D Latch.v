//When the en is high, D flows through to Q and is transparent, but when the en is low the latch holds its output Q even if D changes.

module d_latch (input d, en, rst, output reg q);
  
  always@(d or en or rst ) begin
    if (rst)
      q <= 1'b0;
    else
      if(en)
        q <= d;
  end
endmodule



module tb();
  reg d;
  reg en;
  reg rst;
  wire q;
  
  // Instantiate DUT
  d_latch dut (.d(d), .en(en), .rst(rst), .q(q));
  
  initial begin
    // Initialize
    rst = 1'b1;
    d = 0;
    en = 0;

    // Apply reset
    #5;
    $display("TIME=%0t | Applying RESET", $time);
    #5 rst = 1'b0;  // Release reset

    // Case 1: Enable=1, D=1 (Latch is transparent)
    #5 d = 1; en = 1;
    #1;  // Allow latch to update before displaying
    $display("TIME=%0t | RST=%0b D=%0b EN=%0b -> Q=%0b", $time, rst, d, en, q);

    // Case 2: Disable latch (Hold value)
    #10 en = 0; d = 0;
    #1;
    $display("TIME=%0t | RST=%0b D=%0b EN=%0b -> Q=%0b", $time, rst, d, en, q);

    // Case 3: Re-enable with new D
    #10 en = 1; d = 0;
    #1;
    $display("TIME=%0t | RST=%0b D=%0b EN=%0b -> Q=%0b", $time, rst, d, en, q);

    #10 $finish;
  end
endmodule

