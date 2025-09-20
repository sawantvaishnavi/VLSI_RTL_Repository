
module tb();
  
  reg [3:0] x;
  reg [39:0] y = "Hello";
  time current_time;
  real float_value ;
  real freq;
 
  
  initial begin
    x = 4'b1111;
    float_value = 3.14;
    freq = 1e6;
  end
  
  initial begin
    
    $display ("x = %h", x);      //Display in hexadecimal format
    $display ("x = %d", x);      //Display in decimal format
    $display ("x = %b", x);      //Display in binary format
    
    $display ("y = %s", y);      //Display as a string
    
    
    #200 current_time = $time;
    $display("Current time = %t",current_time);      //Display in time format

    $display ("float_value = %f", float_value);          
    $display ("float_value = %0.2f", float_value);       

    $display ("float_value = %e", float_value);       // converting float_value into exponential format

    $display ("Value of freq = %0d", freq);        //conversion of exponential value into decimal
    
  end
  
  initial begin
    $dumpfile ("dump.vcd");
    $dumpvars;
  end
endmodule

