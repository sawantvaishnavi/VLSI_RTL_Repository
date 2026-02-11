/// Method1: Using Case Statement ///

module mux_4x1 (input i0, i1, i2, i3, output reg out, input [1:0]sel);
  
  always@(i0 or i1 or i2 or i3 or sel)
    begin     
      case(sel)
        2'b00: out = i0;
        2'b01: out = i1;
        2'b10: out = i2;
        2'b11: out = i3;
        default: out = 0;
      endcase
    end   
endmodule


/// Method2: Using if-else Statement ///
module mux_4x1_using_ifelse (input i0, i1, i2, i3, output reg out, input [1:0]sel);
  
  always@(i0 or i1 or i2 or i3 or sel)
    begin
      if(sel == 2'b00)
        out = i0;
      else if (sel == 2'b01)
        out = i1;
      else if (sel == 2'b10)
        out = i2;
      else
        out = i3;
    end  
endmodule


/// Method3: Using Conditional Operator ///
module mux_4x1_using_assign (input i0, i1, i2, i3, output out, input [1:0]sel);
  
  assign out = sel[1]?(sel[0]? i3:i2):(sel[0]? i1:i0);
  
endmodule
