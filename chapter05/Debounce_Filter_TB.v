// Testbench for Debounce Filter
module Debounce_Filter_TB ();
 
  reg r_Clk = 1'b0, r_Bouncy = 1'b0;
  always #2 r_Clk <= !r_Clk;

  Debounce_Filter #(.DEBOUNCE_LIMIT(4)) UUT
  (.i_Clk(r_Clk),
   .i_Bouncy(r_Bouncy),
   .o_Debounced(w_Debounced));
   
  initial begin
    // Required for EDA Playground
    $dumpfile("dump.vcd"); 
    $dumpvars;
    
    repeat(8) @(posedge r_Clk);
    
    r_Bouncy <= 1'b1; // toggle state of input pin
    
    repeat(1) @(posedge r_Clk);
    
    r_Bouncy <= 1'b0; // simulate a glitch/bounce of switch
    
    repeat(1) @(posedge r_Clk);
    
    r_Bouncy <= 1'b1; // bounce goes away
    
    repeat(6) @(posedge r_Clk);
       
    $display("Test Complete");
    $finish();
  end
   
endmodule
