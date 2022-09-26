 -- Top of State Machine Project
 -- Creates a Memory Game
 -- To Start: User pushes SW1 and SW2 at the same time
 -- Game will display random pattern that user must repeat
 -- If you get to GAME_LIMIT correctly, you win! 
 -- Winners will see 0xAA displayed on 7-segment display
 -- If you make a mistake you lose and see 0xEE displayed.
 -- 
 -- Uses code from previous chapters including LFSR, Debounce, and Counters.
 -- Also shows how 7-segment displays work.

library IEEE;
use IEEE.std_logic_1164.all;

entity State_Machine_Project_Top is
  port (
    i_Clk : in std_logic;
    -- Input Switches for entering pattern
    i_Switch_1 : in std_logic;
    i_Switch_2 : in std_logic;
    i_Switch_3 : in std_logic;
    i_Switch_4 : in std_logic;
    -- Output LEDs for displaying pattern
    o_LED_1 : out std_logic;
    o_LED_2 : out std_logic;
    o_LED_3 : out std_logic;
    o_LED_4 : out std_logic;
    -- Tens Digit of Scoreboard
    o_Segment1_A : out std_logic;
    o_Segment1_B : out std_logic;
    o_Segment1_C : out std_logic;
    o_Segment1_D : out std_logic;
    o_Segment1_E : out std_logic;
    o_Segment1_F : out std_logic;
    o_Segment1_G : out std_logic;
    -- Ones Digit of Scoreboard
    o_Segment2_A : out std_logic;
    o_Segment2_B : out std_logic;
    o_Segment2_C : out std_logic;
    o_Segment2_D : out std_logic;
    o_Segment2_E : out std_logic;
    o_Segment2_F : out std_logic;
    o_Segment2_G : out std_logic);

end entity State_Machine_Project_Top;

architecture RTL of State_Machine_Project_Top is

  constant GAME_LIMIT     : integer := 7;         -- Incease to make game harder
  constant CLKS_PER_SEC   : integer := 25000000;  -- 25 MHz clock
  constant DEBOUNCE_LIMIT : integer := 250000;    -- 10 ms debounce filter

  signal w_Switch_1, w_Switch_2, w_Switch_3, w_Switch_4 : std_logic;
  signal w_Score : std_logic_vector(7 downto 0);
  signal w_Segment1_A, w_Segment1_B, w_Segment1_C, w_Segment1_D : std_logic;
  signal w_Segment1_E, w_Segment1_F, w_Segment1_G : std_logic;
  signal w_Segment2_A, w_Segment2_B, w_Segment2_C, w_Segment2_D : std_logic;
  signal w_Segment2_E, w_Segment2_F, w_Segment2_G : std_logic;

begin

  Debounce_SW1 : entity work.Debounce_Filter 
    generic map ( 
      DEBOUNCE_LIMIT => DEBOUNCE_LIMIT)
    port map (
      i_Clk       => i_Clk,
      i_Bouncy    => i_Switch_1,
      o_Debounced => w_Switch_1);

  Debounce_SW2 : entity work.Debounce_Filter 
    generic map ( 
      DEBOUNCE_LIMIT => DEBOUNCE_LIMIT)
    port map (
      i_Clk       => i_Clk,
      i_Bouncy    => i_Switch_2,
      o_Debounced => w_Switch_2);
  
  Debounce_SW3 : entity work.Debounce_Filter 
    generic map ( 
      DEBOUNCE_LIMIT => DEBOUNCE_LIMIT)
    port map (
      i_Clk       => i_Clk,
      i_Bouncy    => i_Switch_3,
      o_Debounced => w_Switch_3);

  Debounce_SW4 : entity work.Debounce_Filter 
    generic map ( 
      DEBOUNCE_LIMIT => DEBOUNCE_LIMIT)
    port map (
      i_Clk       => i_Clk,
      i_Bouncy    => i_Switch_4,
      o_Debounced => w_Switch_4);
  
  Game_Inst : entity work.State_Machine_Game
    generic map (
      CLKS_PER_SEC => CLKS_PER_SEC,
      GAME_LIMIT   => GAME_LIMIT) 
    port map ( 
      i_Clk      => i_Clk,
      i_Switch_1 => w_Switch_1,
      i_Switch_2 => w_Switch_2,
      i_Switch_3 => w_Switch_3,
      i_Switch_4 => w_Switch_4,
      o_Score    => w_Score,
      o_LED_1    => o_LED_1,
      o_LED_2    => o_LED_2,
      o_LED_3    => o_LED_3,
      o_LED_4    => o_LED_4);

  -- Bits 7:4 drive the tens digit of the Scoreboard.
  Digit_Tens : entity work.Binary_To_7Segment
    port map (
      i_Clk        => i_Clk,
      i_Binary_Num => w_Score(7 downto 4),
      o_Segment_A  => w_Segment1_A,
      o_Segment_B  => w_Segment1_B,
      o_Segment_C  => w_Segment1_C,
      o_Segment_D  => w_Segment1_D,
      o_Segment_E  => w_Segment1_E,
      o_Segment_F  => w_Segment1_F,
      o_Segment_G  => w_Segment1_G);

  -- Bits 3:0 drive the ones digit of the Scoreboard.
  Digit_Ones : entity work.Binary_To_7Segment
    port map (
      i_Clk        => i_Clk,
      i_Binary_Num => w_Score(3 downto 0),
      o_Segment_A  => w_Segment2_A,
      o_Segment_B  => w_Segment2_B,
      o_Segment_C  => w_Segment2_C,
      o_Segment_D  => w_Segment2_D,
      o_Segment_E  => w_Segment2_E,
      o_Segment_F  => w_Segment2_F,
      o_Segment_G  => w_Segment2_G);
    
  -- Invert needed on Go Board
  o_Segment1_A <= not w_Segment1_A;
  o_Segment1_B <= not w_Segment1_B;
  o_Segment1_C <= not w_Segment1_C;
  o_Segment1_D <= not w_Segment1_D;
  o_Segment1_E <= not w_Segment1_E;
  o_Segment1_F <= not w_Segment1_F;
  o_Segment1_G <= not w_Segment1_G;

  o_Segment2_A <= not w_Segment2_A;
  o_Segment2_B <= not w_Segment2_B;
  o_Segment2_C <= not w_Segment2_C;
  o_Segment2_D <= not w_Segment2_D;
  o_Segment2_E <= not w_Segment2_E;
  o_Segment2_F <= not w_Segment2_F;
  o_Segment2_G <= not w_Segment2_G;

end RTL;