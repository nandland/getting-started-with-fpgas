// This module is used to debounce any switch or button coming into the FPGA.
// Does not allow the output to change unless the input i_Bouncy is
// steady for enough time (not toggling).
//
// Parameters: 
// DEBOUNCE_LIMIT - Determines number of clock cycles that input must be stable
//                  before output is updated. 

module Debounce_Filter #(parameter DEBOUNCE_LIMIT = 250000) (
  input i_Clk,
  input i_Bouncy,
  output o_Debounced);
 
  // Will set the width of this counter based on the input parameter
  reg [$clog2(DEBOUNCE_LIMIT)-1:0] r_Count;
  reg r_State;
 
  always @(posedge i_Clk)
  begin
    // Bouncy input is different than internal state value, so an input is
    // changing.  Increase the counter until it is stable for enough time.  
    if (i_Bouncy !== r_State && r_Count < DEBOUNCE_LIMIT)
    begin
      r_Count <= r_Count + 1;
    end
    
    // End of counter reached, switch is stable, register it, reset counter
    else if (r_Count == DEBOUNCE_LIMIT)
    begin
      r_State <= i_Bouncy;
      r_Count <= 0;
    end 

    // Switches are the same state, reset the counter
    else
    begin
      r_Count <= 0;
    end
  end
 
  // Assign internal register to output (debounced!)
  assign o_Debounced = r_State;
 
endmodule
