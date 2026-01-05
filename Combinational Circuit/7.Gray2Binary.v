module g2b_converter #(parameter Width=4)(input [Width-1:0] gray, 
                                          output [Width-1:0] binary);
  
  genvar i;
  generate 
    for(i=0; i<Width; i++) begin
      assign binary[i] =  ^gray[Width-1:i] ;
    end
  endgenerate
endmodule



////////////////Testbench////////////
`timescale 1ns/1ns

module tb;

  reg  [3:0] gray;     // stimulus (input to DUT)
  wire [3:0] binary;   // output from DUT

  // Instantiate DUT
  g2b_converter #(.Width(4)) dut (
    .gray   (gray),
    .binary (binary)
  );

  initial begin
    $monitor("Time = %0t | Gray = %b --> Binary = %b", 
              $time,       gray,          binary);

    // Apply Gray code patterns
    gray = 4'b0000; #10;
    gray = 4'b1011; #10;
    gray = 4'b0111; #10;
    gray = 4'b0101; #10;
    gray = 4'b1100; #10;
    gray = 4'b1111; #10;
    gray = 4'b1010; #10;

    #10 $finish;
  end

endmodule
