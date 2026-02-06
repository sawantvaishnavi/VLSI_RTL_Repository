module freq_divide_by_4 (
    input  clk,
    input  rst,      // active-high reset
    output reg qa,
    output reg qb
);

always @(posedge clk) begin
    if (rst) begin
        qa <= 1'b0;
        qb <= 1'b0;
    end
    else begin
        qa <= ~qa;           // divide-by-2
        if (qa)              // toggle qb every 2 toggles of qa
            qb <= ~qb;       // divide-by-4
    end
end

endmodule



//////////TB///////////
module tb;
 
  wire qa, qb;
  reg clk;
  reg rst;
  
  freq_divide_by_4  dut ( clk,rst, qa, qb);
  
  initial clk = 0;
  always #10 clk = ~clk;
  
  initial begin
    rst =1;
    #25 rst= 0;
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars ();
  end
  initial begin
    #200;
    $finish;
  end
endmodule
  
