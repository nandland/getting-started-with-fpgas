// Top of Demux and Count Demonstration
// Instantiates a Counter, which generates a ~1 second toggling signal
// 
// User can select which LED is illuminated with this toggling signal 
// by using using S1 and S2 to drive select bits of a demux.
// Demonstrates demuxing of this toggling signal to one of 4 LED outputs.

module Demux_Count_Project_Top 
 (input i_Clk,
  input i_Switch_1,
  input i_Switch_2,
  output o_LED_1,
  output o_LED_2,
  output o_LED_3,
  output o_LED_4);

  // Equivalent to 2^22 - 1, which is what the LFSR counted up to
  localparam COUNT_LIMIT = 4194303;

  wire w_Counter_Toggle;

  Count_And_Toggle #(.COUNT_LIMIT(COUNT_LIMIT)) Toggle_Counter
   (.i_Clk(i_Clk),
    .i_Enable(1'b1),
    .o_Toggle(w_Counter_Toggle));
   
  Demux_1_To_4 Demux_Inst 
   (.i_Data(w_Counter_Toggle),
    .i_Sel0(i_Switch_1),
    .i_Sel1(i_Switch_2),
    .o_Data0(o_LED_1),
    .o_Data1(o_LED_2),
    .o_Data2(o_LED_3),
    .o_Data3(o_LED_4));

endmodule