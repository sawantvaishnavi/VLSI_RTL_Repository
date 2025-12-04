module cdc_example_with_synchronizer(

    input wire clkA,
    input wire clkB,
    input wire rst,
    input wire trigger,   // Input in clkA domain
    output reg signalB_sync // Output safely in clkB domain 
    ); 
    
    //source ff in clkA domain
    reg signalA;
    
    always @(posedge clkA or posedge rst) begin
    if (rst)
    signalA <= 1'b0;
    else
    signalA <= trigger;
    end
    
    
// Two-stage synchronizer in clkB domain
(* ASYNC_REG = "TRUE" *) reg sync_ff1, sync_ff2;
always @(posedge clkB or posedge rst) //synchronizes is operated in destination clock domain
begin
if (rst) begin
sync_ff1     <= 1'b0;
sync_ff2     <= 1'b0;
signalB_sync <= 1'b0;
end
else
begin
sync_ff1    <= signalA;
sync_ff2    <= sync_ff1;
signalB_sync <= sync_ff2;
end
end
endmodule
