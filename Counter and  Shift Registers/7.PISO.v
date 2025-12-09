module PISO (input clk, 
             input rst, 
             input load,  //Loads all 8 bits at once into the register
             input [7:0] parallel_in, 
             output reg serial_out);
  
  reg [7:0] shift_register;
  
  always@(posedge clk or posedge rst) begin
    if (rst) begin
      shift_register<= 8'b00000000;
      serial_out <= 0;
    end
    else if (load)
      shift_register <= parallel_in;
    else begin
      serial_out <= shift_register[0];
      shift_register <= shift_register >> 1;
    end
  end
  
endmodule


//////////Testbench///////////
`timescale 1ns/1ps

module tb_PISO;

  reg clk;
  reg rst;
  reg load;
  reg [7:0] parallel_in;
  wire serial_out;

  // Instantiate DUT
  PISO dut (
    .clk        (clk),
    .rst        (rst),
    .load       (load),
    .parallel_in(parallel_in),
    .serial_out (serial_out)
  );

  // Clock generation: 10 ns period
  initial begin
    clk = 0;
    forever #5 clk = ~clk;   // Toggles every 5 ns → 10 ns period
  end

  initial begin
    // Waveform dump (optional, for GTKWave/SimVision/etc.)
    $dumpfile("piso_tb.vcd");
    $dumpvars(0, tb_PISO);

    // Initialize
    rst = 1;
    
    // Keep reset high for some time
    #20;
    rst = 0;

    // =========================
    // TEST 1: parallel_in = 10110010
    // =========================
    @(negedge clk);
    parallel_in = 8'b10110010;
    load = 1;   // Load data into shift_register

    @(negedge clk);
    load = 0;   // Start shifting from next clock

    $display("\n===== TEST 1: parallel_in = 10110010 =====");
    repeat (10) begin
      @(posedge clk);
      $display("Time = %0t ns | rst = %b | load = %b | parallel_in = %b | shift_register = %b | serial_out = %b",
                $time, rst, load, parallel_in, dut.shift_register, serial_out);
    end

    // =========================
    // TEST 2: parallel_in = 11001100
    // =========================
    @(negedge clk);
    parallel_in = 8'b11001100;
    load = 1;   // Load second pattern

    @(negedge clk);
    load = 0;   // Start shifting

    $display("\n===== TEST 2: parallel_in = 11001100 =====");
    repeat (10) begin
      @(posedge clk);
      $display("Time = %0t ns | rst = %b | load = %b | parallel_in = %b | shift_register = %b | serial_out = %b",
                $time, rst, load, parallel_in, dut.shift_register, serial_out);
    end

    $finish;
  end

endmodule
