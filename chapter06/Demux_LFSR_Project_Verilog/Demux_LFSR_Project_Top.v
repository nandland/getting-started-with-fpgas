// Top of Demux and LFSR Demonstration
// Instantiates an LFSR, which generates a ~1 second toggling signal
// 
// User can select which LED is illuminated with this toggling signal 
// by using using S1 and S2 to drive select bits of a demux.
// Demonstrates demuxing of any of these to a single LED output (o_LED_1)
// 
// LFSR takes 2^22-1 clock cycles to run through all its combinations
// Pulses w_Slow_Pulse each time it completes
// We take slow pulse and use that to toggle the LED drive signal.
// The toggling signal can be muxed to each LED output
// 
// For resource comparison, you can try removing the LFSR and instead
// uncommenting the traditional counter.

module Demux_Project_Top 
   (input i_Clk,
    input i_Switch_1,
    input i_Switch_2,
    output o_LED_1,
    output o_LED_2,
    output o_LED_3,
    output o_LED_4);

   // LFSR takes 2^22-1 (4,194,303) clock cycles to complete
   localparam NUM_LFSR_BITS = 22;

   // Set to 1 to use LFSR, set to 0 to use Counter
   localparam USE_LFSR = 1;
   
   reg r_LFSR_Toggle = 1'b0;
   wire w_Slow_Pulse;
   wire w_LED_Toggle, w_Counter_Toggle;

   LFSR #(.NUM_BITS(NUM_LFSR_BITS)) Toggle_LFSR 
   (.i_Clk(i_Clk),
    .i_Enable(1'b1),
    .i_Seed_DV(1'b0),
    .i_Seed_Data({NUM_LFSR_BITS{1'b0}}), // replcicator
    .o_LFSR_Data(), // unconnected
    .o_LFSR_Done(w_Slow_Pulse));

   always @(posedge i_Clk)
   begin
      if (w_Slow_Pulse)
         r_LFSR_Toggle <= !r_LFSR_Toggle;
   end

   Count_And_Toggle #(.COUNT_LIMIT(2**NUM_LFSR_BITS)) Toggle_Counter
    (.i_Clk(i_Clk),
     .i_Enable(1'b1),
     .o_Toggle(w_Counter_Toggle));
   
   assign w_LED_Toggle = USE_LFSR ? r_LFSR_Toggle : w_Counter_Toggle;

   Demux_1_To_4 Demux_Inst 
    (.i_Data(w_LED_Toggle),
     .i_Sel0(i_Switch_1),
     .i_Sel1(i_Switch_2),
     .o_Data0(o_LED_1),
     .o_Data1(o_LED_2),
     .o_Data2(o_LED_3),
     .o_Data3(o_LED_4));

endmodule