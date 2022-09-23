// Top of State Machine Project
// Creates a Memory Game
// To Start: User pushes SW1 and SW2 at the same time
// Game will display random pattern that user must repeat
// If you get to GAME_LIMIT correctly, you win! 
// Winners will see 0xAA displayed on 7-segment display
// If you make a mistake you lose and see 0xEE displayed.
// 
// Uses code from previous chapters including LFSR, Debounce, and Counters.
// Also shows how 7-segment displays work.

module State_Machine_Project_Top 
 (input i_Clk,
  // Input Switches for entering pattern
  input i_Switch_1,
  input i_Switch_2,
  input i_Switch_3,
  input i_Switch_4,
  // Output LEDs for displaying pattern
  output o_LED_1,
  output o_LED_2,
  output o_LED_3,
  output o_LED_4,
  // Tens Digit of Scoreboard
  output o_Segment1_A,
  output o_Segment1_B,
  output o_Segment1_C,
  output o_Segment1_D,
  output o_Segment1_E,
  output o_Segment1_F,
  output o_Segment1_G,
  // Ones Digit of Scoreboard
  output o_Segment2_A,
  output o_Segment2_B,
  output o_Segment2_C,
  output o_Segment2_D,
  output o_Segment2_E,
  output o_Segment2_F,
  output o_Segment2_G);

  localparam GAME_LIMIT     = 7;        // Incease to make game harder
  localparam CLKS_PER_SEC   = 25000000; // 25 MHz clock
  localparam DEBOUNCE_LIMIT = 250000;   // 10 ms debounce filter

  wire w_Switch_1, w_Switch_2, w_Switch_3, w_Switch_4;
  wire w_Segment1_A, w_Segment1_B, w_Segment1_C, w_Segment1_D, w_Segment1_E, w_Segment1_F, w_Segment1_G;
  wire w_Segment2_A, w_Segment2_B, w_Segment2_C, w_Segment2_D, w_Segment2_E, w_Segment2_F, w_Segment2_G;
  wire [7:0] w_Score;

  // Debounce all switch inputs to remove mechanical glitches
  Debounce_Filter #(.DEBOUNCE_LIMIT(DEBOUNCE_LIMIT)) Debounce_SW1
   (.i_Clk(i_Clk), 
    .i_Bouncy(i_Switch_1),
    .o_Debounced(w_Switch_1));
   
  Debounce_Filter #(.DEBOUNCE_LIMIT(DEBOUNCE_LIMIT)) Debounce_SW2
   (.i_Clk(i_Clk), 
    .i_Bouncy(i_Switch_2),
    .o_Debounced(w_Switch_2));

  Debounce_Filter #(.DEBOUNCE_LIMIT(DEBOUNCE_LIMIT)) Debounce_SW3
   (.i_Clk(i_Clk), 
    .i_Bouncy(i_Switch_3),
    .o_Debounced(w_Switch_3));

  Debounce_Filter #(.DEBOUNCE_LIMIT(DEBOUNCE_LIMIT)) Debounce_SW4
   (.i_Clk(i_Clk), 
    .i_Bouncy(i_Switch_4),
    .o_Debounced(w_Switch_4));

  State_Machine_Game #(.CLKS_PER_SEC(CLKS_PER_SEC),
                       .GAME_LIMIT(GAME_LIMIT)) Game_Inst
   (.i_Clk(i_Clk),
    .i_Switch_1(w_Switch_1),
    .i_Switch_2(w_Switch_2),
    .i_Switch_3(w_Switch_3),
    .i_Switch_4(w_Switch_4),
    .o_Score(w_Score),
    .o_LED_1(o_LED_1),
    .o_LED_2(o_LED_2),
    .o_LED_3(o_LED_3),
    .o_LED_4(o_LED_4));

  // Bits 7:4 drive the tens digit of the Scoreboard.
  Binary_To_7Segment Digit_Tens
   (.i_Clk(i_Clk),
    .i_Binary_Num(w_Score[7:4]),
    .o_Segment_A(w_Segment1_A),
    .o_Segment_B(w_Segment1_B),
    .o_Segment_C(w_Segment1_C),
    .o_Segment_D(w_Segment1_D),
    .o_Segment_E(w_Segment1_E),
    .o_Segment_F(w_Segment1_F),
    .o_Segment_G(w_Segment1_G));

  // Bits 3:0 drive the ones digit of the Scoreboard.
  Binary_To_7Segment Digit_Ones
   (.i_Clk(i_Clk),
    .i_Binary_Num(w_Score[3:0]),
    .o_Segment_A(w_Segment2_A),
    .o_Segment_B(w_Segment2_B),
    .o_Segment_C(w_Segment2_C),
    .o_Segment_D(w_Segment2_D),
    .o_Segment_E(w_Segment2_E),
    .o_Segment_F(w_Segment2_F),
    .o_Segment_G(w_Segment2_G));
    
  // Invert needed on Go Board
  assign o_Segment1_A = !w_Segment1_A;
  assign o_Segment1_B = !w_Segment1_B;
  assign o_Segment1_C = !w_Segment1_C;
  assign o_Segment1_D = !w_Segment1_D;
  assign o_Segment1_E = !w_Segment1_E;
  assign o_Segment1_F = !w_Segment1_F;
  assign o_Segment1_G = !w_Segment1_G;

  assign o_Segment2_A = !w_Segment2_A;
  assign o_Segment2_B = !w_Segment2_B;
  assign o_Segment2_C = !w_Segment2_C;
  assign o_Segment2_D = !w_Segment2_D;
  assign o_Segment2_E = !w_Segment2_E;
  assign o_Segment2_F = !w_Segment2_F;
  assign o_Segment2_G = !w_Segment2_G;

endmodule
