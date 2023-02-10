// Testbench of State Machine Game
// Simple tests to ensure that state machine works

module State_Machine_Game_TB ();

  localparam CLKS_PER_SEC = 6;
  localparam GAME_LIMIT = 3;
  reg r_Clk = 1'b0;
  reg r_Switch_1 = 1'b0, r_Switch_2 = 1'b0;
  reg r_Switch_3 = 1'b0, r_Switch_4 = 1'b0;
  wire w_LED_1, w_LED_2, w_LED_3, w_LED_4;
  wire [3:0] w_Score;

  always #2 r_Clk <= !r_Clk;

  State_Machine_Game #(.CLKS_PER_SEC(CLKS_PER_SEC),
                       .GAME_LIMIT(GAME_LIMIT)) Game_Inst
   (.i_Clk(r_Clk),
    .i_Switch_1(r_Switch_1),
    .i_Switch_2(r_Switch_2),
    .i_Switch_3(r_Switch_3),
    .i_Switch_4(r_Switch_4),
    .o_Score(w_Score),
    .o_LED_1(w_LED_1),
    .o_LED_2(w_LED_2),
    .o_LED_3(w_LED_3),
    .o_LED_4(w_LED_4));

  // Sets switches to desired value for one clock cycle, 
  // then drives back to 0.
  task set_switches;
    input i_1, i_2, i_3, i_4;
    begin
      @(posedge r_Clk);
      r_Switch_1 <= i_1;
      r_Switch_2 <= i_2;
      r_Switch_3 <= i_3;
      r_Switch_4 <= i_4;
      @(posedge r_Clk);
      r_Switch_1 <= 1'b0;
      r_Switch_2 <= 1'b0;
      r_Switch_3 <= 1'b0;
      r_Switch_4 <= 1'b0;
      @(posedge r_Clk);
    end
  endtask
  
  initial begin
    // Required for EDA Playground
    $dumpfile("dump.vcd"); 
    $dumpvars;
    set_switches(0, 0, 0, 0);
    repeat(CLKS_PER_SEC) @(posedge r_Clk);
    set_switches(1, 1, 0, 0);
    repeat(2*CLKS_PER_SEC) @(posedge r_Clk);
    set_switches(0, 0, 0, 1);
    repeat(3*CLKS_PER_SEC) @(posedge r_Clk);
    set_switches(0, 0, 0, 1);
    repeat(2 * CLKS_PER_SEC) @(posedge r_Clk);
    set_switches(0, 0, 0, 1);
    repeat(2 * CLKS_PER_SEC) @(posedge r_Clk);
    
    // Reset game back to start
    set_switches(1, 1, 0, 0);
    repeat(2*CLKS_PER_SEC) @(posedge r_Clk);
       
    $display("Test Complete");
    $finish();
  end
   
endmodule
