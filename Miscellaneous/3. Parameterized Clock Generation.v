// - Reference clock: 100 MHz (`clk`)
// - Parameterized secondary clock (`clk50`)
//   - Adjustable frequency (Hz)
//   - Duty cycle (0.0 – 1.0)
//   - Phase shift (ns)
// - Utility tasks:
//    - `calc` – computes `ton`, `toff`, and phase
//    - `clkgen` – generates the programmable clock waveform


`timescale 1ns / 1ps
 
module tb();
 
  
  reg clk = 0; 
  reg clk50 = 0;
  
  always #5 clk = ~clk; //100 MHz
    
  /*
  real phase = 10;
  real ton = 5;
  real toff = 5;
  */
/*  
task clkgen(input real phase, input real ton, input real toff);  
  #phase;
  while(1) begin
  clk50 = 1;
  #ton;
  clk50 = 0;
  #toff;
  end
endtask
*/
 
 
task calc (input real freq_hz, input real duty_cycle, input real phase, output real pout, output real ton, output real toff); begin
pout = phase;
ton = (1.0 / freq_hz) * duty_cycle * 1000_000_000;
toff =  (1000_000_000 / freq_hz) - ton;
end
endtask
 
 
task clkgen(input real phase, input real ton, input real toff);  begin
  @(posedge clk);
  #phase;
  while(1) begin
  clk50 = 1;
  #ton;
  clk50 = 0;
  #toff;
  end
  end
endtask
 
real phase;
real ton;
real toff;
 
 
initial begin
calc(100_000_000, 0.1, 2, phase, ton, toff);
clkgen(phase, ton, toff);
end
 
 
 
  initial begin
    #200;
    $finish();
  end
  
endmodule
