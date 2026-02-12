module vending_machine (
	input clk, rst, cancle,
    input [1:0] coin,
    input [1:0] sel,
  	output reg pr1, pr2, pr3, change);
  
  parameter s0=3'b000, s5=3'b001, s10=3'b010, s15=3'b011, s20=3'b100;
  
  reg [2:0] pstate, nstate;
  
  always@(posedge clk or posedge rst)
  begin
    if(rst)
      pstate <= s0;
    else
      pstate <= nstate;
  end
  
  //next state logic (combinational)
  always(*)
    begin
      case(pstate)
        
        s0: begin
          if(coin == 2'b01)
            nstate = s5;
          else if(coin == 2'b10)
            nstate = s10;
          else
            nstate = s0;  
        end
        
        s5: begin
          if(coin == 2'b01)
            nstate = s10;
          else if (coin == 2'b10)
            nstate = s15;
          else if (cancle) 
            nstate = s0;
          else
            nstate = s5;
        end
        
        s10: begin
          if(coin == 2'b01)
            nstate = s15;
          else if (coin == 2'b10)
            nstate = s20;
          else if (cancle) 
            nstate = s0;
          else
            nstate = s10;
        end
        
        s15: begin
          if(coin == 2'b01)
            nstate = s20;
          else if(cancle)
            nstate = s0;
          else
            nstate = s15;
        end
        
        s20: begin
          if (cancle)
            nstate = s0;
          else
            nstate = s20;
        end
        
        default: nstate = s0;
        
      endcase
    end
  
  
  //output logic
  always@(posedge clk or posedge rst) 
    begin
      if(rst) begin
        pr1 <= 0;
        pr2 <= 0;
        pr3 <= 0;
        change <= 0;
      end
      
      else
        begin
        pr1 <= 0;
        pr2 <= 0;
        pr3 <= 0;
        change <= 0;
     
      
      case (pstate)
        
        s5: begin
          if(sel == 2'b00) begin
            pr1 <= 1;  //giving 5 rupee and selecting product A
            change <= 0;
          end
        end
        
        s10: begin
          if(sel == 2'b00) begin
            pr1 <= 1; // giving 10 rupee secting 5 rupee product
            change <= 1;  // change 5 rupee
          end
          else if (sel == 2'b01) begin
            pr2 <= 1;
            change <= 0;
          end
        end
        
        s15: begin
          if(sel == 2'b01) begin
            pr2 <= 1;
            change <= 1;
          end 
        end
        
        s20: begin
          if(sel == 2'b00) begin
            pr1 <= 1;
            change <= 1; //15 rupee change
          end
          else if (sel == 2'b01) begin
            pr2 <= 1;
            change <= 1;
          end
          else if (sel == 2'b10) begin
            pr3 <= 1;
            change <= 0;
          end
        end
      endcase
      
      if (cancle)
        change <= 1;
    end
       end
endmodule
