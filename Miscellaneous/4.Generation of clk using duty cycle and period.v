// Calculate Ton(high_time) and Toff(low_time) using period and duty cycle, and using this Ton and Toff generate Clk.


module tb;

  // Signal declaration
  reg clk = 0;

  // Parameters for waveform generation
  real period = 50.0;       // Period in nanoseconds
  real duty_cycle = 0.6;    // Duty cycle (60%)
  real high_time, low_time;  /// high and low time

  
  task get_high_low_times (input real period, input real duty_cycle, output real high_time, output real low_time); begin
    high_time = period * duty_cycle;
    low_time = (1 - duty_cycle) * period;
  end 
  endtask
  
  initial begin
    while (1) begin
      clk = 0;
      #low_time;
      clk = 1;
      #high_time;
    end
  end

  initial begin 
    get_high_low_times (50, 0.6, high_time, low_time );
 end
  
  initial begin 
    $dumpfile("dump.vcd"); 
    $dumpvars;
    #500;
    $finish;
  end 
  
endmodule

