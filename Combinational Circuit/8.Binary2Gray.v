module b2g_converter #(parameter WIDTH = 4)
(
  input  [WIDTH-1:0] binary, 
  output [WIDTH-1:0] gray
);

  genvar i;

  // MSB is same in Gray and Binary
  assign gray[WIDTH-1] = binary[WIDTH-1];

  // Remaining bits: gray[i] = binary[i] ^ binary[i+1]
  generate
    for (i = 0; i < WIDTH-1; i = i + 1) begin : gen_b2g
      assign gray[i] = binary[i] ^ binary[i+1];
    end
  endgenerate

endmodule



/////////////////Testbench/////////////
`timescale 1ns/1ns

module tb;

  reg  [3:0] binary;
  wire [3:0] gray;

  // Instantiate DUT
  b2g_converter #(.WIDTH(4)) dut (
    .binary(binary),
    .gray(gray)
  );

  initial begin
    $monitor("Time = %0t | Binary = %b --> Gray = %b", 
              $time,       binary,          gray);

    binary = 4'b1011; #10;
    binary = 4'b0111; #10;
    binary = 4'b0101; #10;
    binary = 4'b1100; #10;
    binary = 4'b1111; #10;

    $finish;
  end

endmodule
