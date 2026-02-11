//// Testbench ////
module tb;
  reg [7:0] a;
  reg [7:0] b;
  wire [15:0] out;
  reg  [3:0] sel;
  
  alu dut (a, b, sel, out);
  
  initial begin
    $monitor("%0t\t %b\t %d\t %d\t %d", $time, sel, a, b, out);
    
    a=8'b0000_1010;
    b=8'b0000_0101;
    
    sel =4'd0; #10;
    sel =4'd1; #10;
    sel =4'd2; #10;
    sel =4'd3; #10;
    sel =4'd4; #10;
    sel =4'd5; #10;
    sel =4'd6; #10;
    sel =4'd7; #10;
    sel =4'd8; #10;
    sel =4'd9; #10;
    sel =4'd10; #10;
    sel =4'd11; #10;
    sel =4'd12; #10;
    sel =4'd13; #10;
    sel =4'd14; #10;
    sel =4'd15; #10;    
  end  
endmodule
