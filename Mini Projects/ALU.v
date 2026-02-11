///// Design ////
module alu (input [7:0] a, b, input [3:0] sel, output reg[15:0] out);  
  always@(*)
    begin    
      case(sel)
        4'b0000: out = a+b;
        4'b0001: out = a-b;
        4'b0010: out = a*b;
        4'b0011: out = a/b;
        4'b0100: out = a<<1;  //left shift
        4'b0101: out = a>>1;  //right shift
        4'b0110: out = {a[6:0], a[7]};  //A rotated left by 1;
        4'b0111: out = {a[0], a[7:1]};  //A rotated right by 1;
        4'b1000: out = a & b;  //logical and
        4'b1001: out = a | b;   //or
        4'b1010: out = ~(a & b);  //nand
        4'b1011: out = ~(a | b);  //nor
        4'b1100: out = a ^ b;      //exor
        4'b1101: out = ~(a ^ b);  //exnor
        4'b1110: out = (a>b)?16'b1: 16'b0; //a greater than b
        4'b1111: out = (a==b)?16'b1: 16'b0; //a equal to b
       default: out = 16'b0;          
      endcase
    end
endmodule

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
