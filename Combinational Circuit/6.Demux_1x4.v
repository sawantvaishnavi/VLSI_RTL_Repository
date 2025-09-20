module demux_1x4 (input din, [1:0] sel, output [3:0] y);
  reg [3:0]y;
  
  always @ (*) begin
     y = 4'b0000; 
//In Verilog simulation, if a signal is not assigned in an always @(*) block, it retains its previous value (just like a latch).therefore squence will be like 0001, 0011, 0111, 1111.
// y = 4'b0000;This clears all outputs to zero.Since you started from all zeros, after the case statement exactly one bit is set to din, others remain 0.
    
    case (sel)
      2'b00 : y[0] = din;
      2'b01 : y[1] = din;
      2'b10 : y[2] = din;
      2'b11 : y[3] = din;
      default : y = 4'b0000;
    endcase 
    
  end
endmodule



//tb
module tb;
  reg din;
  reg [1:0] sel;
  wire [3:0] y;
  
  demux_1x4 dut (din, sel, y);
  
  initial begin 
    $dumpfile ("dump.vcd");
    $dumpvars(1);
    
    $monitor ("din = %b, sel=%b, y=%b",din, sel, y);
    din= 1;
    
    for (int i =0; i<4; i = i +1) begin
      sel = i;
    #10;
    end
  end
endmodule 
