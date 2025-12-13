//////////DESIGN/////////
module synchronous_fifo #
  ( parameter WIDTH = 8,
    parameter DEPTH = 16 )
  ( input clk,
    input reset,
    input [WIDTH-1:0] d_in,
    input wr_en,
    input rd_en,
    output reg [WIDTH-1:0] d_out,
    output full,
    output empty
  );
  
  //memory
  reg [WIDTH-1:0] fifo [0:DEPTH-1];
 
  //pointer
  reg [$clog2(DEPTH)-1:0] wr_ptr, rd_ptr;
  reg [$clog2(DEPTH)-1:0] count;
  
  //reset logic
  always@(posedge clk or negedge reset) begin
    if(!reset)
      begin
        wr_ptr <= 0;
        rd_ptr <= 0;
        count  <= 0;
        d_out  <= 0;
      end
    else 
      begin
        if (wr_en && !full) begin
          fifo[wr_ptr] <= d_in;
          wr_ptr 	   <= (wr_ptr + 1) % DEPTH;
          count		   <= count + 1;
        end 
        
        if (rd_en && !empty) begin
          d_out <= fifo [rd_ptr];
          rd_ptr <= (rd_ptr + 1) % DEPTH;	
          count  <= count - 1;
        end
      end
  end
  
  //status flags
  assign full = (count == DEPTH);  //count logic is reached to fifo depth , then full signal will be high
  assign empty = (count == 0); // count is at 0 then empty flag will be high
endmodule


/////////VERIFICATION///////////
