//A single-port RAM has only one data port, which means that read and write operations cannot occur simultaneously at different addresses. If a write operation is in progress, a read operation must wait, and vice versa.
//In clocked always blocks, missing else means HOLD, not LATCH.
//Latches are inferred only in combinational blocks like always @(*), not in edge-triggered blocks.

module Single_Port_RAM ( 
  input clk, 
  input rd, 
  input wr, 
  input cs,
  input [9:0] addr,
  input [7:0] wdata,
  output reg [7:0] rdata
   );
  
  reg [7:0] mem [1023:0] ;
 
  
  always@(posedge clk)
    if(cs) begin
      
       //write operation
      if (wr && !rd)
        mem[addr] <= data;
  
      //read operation
      if(rd && !wr)
        d_out <= mem [addr];
  
    end
  
  
endmodule
