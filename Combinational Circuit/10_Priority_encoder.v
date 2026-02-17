//Q4 — 4:2 Priority Encoder
//The valid signal indicates whether the input (in in this case) contains any active bits (i.e., whether any bit in the 4-bit input is 1). 
//It helps to indicate if a valid output was generated.

module priority_encoder (
  input logic [3:0] in,
  output logic valid,
  output logic [1:0] out );
  
  always_comb 
    begin
      //default:
      valid = 0;
      out = 2'b0;
      
      if(in[3]) begin
        out = 2'b11;
        valid = 1'b1;
      end
      else if (in[2]) begin
        out = 2'b10;
        valid = 1'b1;
      end
      else if (in[1]) begin
        out = 2'b01;
        valid = 1'b1;
      end
      else if (in[0]) begin
        out = 2'b00;
        valid = 1'b1;
      end
      //does not infer latch because default conditions metioned already
    end
endmodule
