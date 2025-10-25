=====================
      Design
=====================
//1.Using Non-blocking
module swap(input clk, input rst, input [7:0] in_a, in_b, 
            output reg [7:0] a, b);

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      a <= 0;
      b <= 0;
    end else begin
      a <= in_b;
      b <= in_a;
    end
  end

endmodule

//2.Using temp
module swap(input clk,
            input [7:0] a_in, b_in,
            output reg [7:0] a_out, b_out);

  reg [7:0] temp;

  always @(posedge clk) begin
    temp = a_in;   // store old a value
    a_out = b_in;  // assign b to a
    b_out = temp;  // assign old a to b
  end

endmodule

//3.Using operator
module swap(input clk,
            input [7:0] a_in, b_in,
            output reg [7:0] a_out, b_out);

  always @(posedge clk) begin
    a_out = a_in + b_in;  // Step 1: a_out = a + b
    b_out = a_out - b_in; // Step 2: b_out = (a + b) - b = a
    a_out = a_out - b_out; // Step 3: a_out = (a + b) - a = b
  end

endmodule

