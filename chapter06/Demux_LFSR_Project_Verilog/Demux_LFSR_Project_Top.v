// Top of Demux and LFSR Demonstration
// Instantiates an LFSR, which generates a ~1 second toggling signal
// 
// User can select which LED is illuminated with this toggling signal 
// by using using S1 and S2 to drive select bits of a demux.
// Demonstrates demuxing of this toggling signal to one of 4 LED outputs.
// 
// LFSR takes 2^22-1 clock cycles to run through all its combinations
// Pulses w_LFSR_Done each time it completes
// We take done pulse and use that to toggle the LED drive signal.
// The toggling signal can be muxed to each LED output

module Demux_LFSR_Project_Top 
 (input i_Clk,
  input i_Switch_1,
  input i_Switch_2,
  output o_LED_1,
  output o_LED_2,
  output o_LED_3,
  output o_LED_4);

  reg r_LFSR_Toggle = 1'b0;
  wire w_LFSR_Done;

  LFSR_22 LFSR_Inst
  (.i_Clk(i_Clk),
   .o_LFSR_Data(), // unconnected
   .o_LFSR_Done(w_LFSR_Done));

  always @(posedge i_Clk)
  begin
    if (w_LFSR_Done)
      r_LFSR_Toggle <= !r_LFSR_Toggle;
  end

  Demux_1_To_4 Demux_Inst 
   (.i_Data(r_LFSR_Toggle),
    .i_Sel0(i_Switch_1),
    .i_Sel1(i_Switch_2),
    .o_Data0(o_LED_1),
    .o_Data1(o_LED_2),
    .o_Data2(o_LED_3),
    .o_Data3(o_LED_4));

endmodule