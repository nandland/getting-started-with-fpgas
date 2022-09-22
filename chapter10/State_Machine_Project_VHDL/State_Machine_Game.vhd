-- Creates the main state machine to control the memory game.
-- Assumes switch inputs to this module have been debounced.
-- Debounce filter is created using implementation from Chapter 5.
-- Push Switch 1 and Switch 2 to start the game.
-- Displays a pseudo-random pattern on the 4 LEDs
-- Pseudo-random pattern is created using the LFSR from Chapter 6.
-- User must use buttons to repeat the pattern. 
-- If they get it correct, will add 1 more LED blink to the sequence
-- until the player makes a mistake. Game is over at 8 successful in a row.

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity State_Machine_Game is 
  generic (
    CLKS_PER_SEC : integer := 250000000;
    GAME_LIMIT   : integer := 6);
  port(
    i_Clk      : in std_logic;
    i_Switch_1 : in std_logic;
    i_Switch_2 : in std_logic;
    i_Switch_3 : in std_logic;
    i_Switch_4 : in std_logic;
    o_Score    : out std_logic_vector(7 downto 0);
    o_LED_1    : out std_logic;
    o_LED_2    : out std_logic;
    o_LED_3    : out std_logic;
    o_LED_4    : out std_logic);

end entity State_Machine_Game;

architecture RTL of State_Machine_Game is

  type t_SM_Main is (IDLE, PATTERN_SHOW, PATTERN_OFF, WAIT_PLAYER, INCR_SCORE, LOSER, WINNER);

  signal r_SM_Main : t_SM_Main;
  signal w_Count_En, w_Toggle, r_Toggle, r_Switch_1, r_Switch_2, r_Switch_3, r_Switch_4, r_Button_DV : std_logic;

  type t_Pattern is array (0 to GAME_LIMIT-1) of std_logic_vector(1 downto 0);
  signal r_Pattern : t_Pattern; -- 2D Array: 2-bit wide x 11 deep (max game size) 
  
  signal w_LFSR_Data : std_logic_vector(21 downto 0);
  signal r_Index : integer range 0 to GAME_LIMIT;
  signal w_Index_SLV : std_logic_vector(7 downto 0);
  signal r_Button_ID : std_logic_vector(1 downto 0);

begin
    
  process (i_Clk) is
  begin
    if rising_edge(i_Clk) then
    
      -- Reset game from any state
    if i_Switch_1 and i_Switch_2 then
      r_SM_Main <= IDLE;
    else
      -- Main state machine switch statement
    
      case r_SM_Main is

        -- Stay in IDLE state until user releases Switch_1 and Switch_2
        when IDLE =>
          if i_Switch_1 = '0' and  i_Switch_2 = '0' then -- wait for reset condition to go away
            o_Score   <= 0;
            r_Index   <= 0;
            r_SM_Main <= PATTERN_SHOW;
          end if;

        -- Shows the next LED in the pattern
        when PATTERN_SHOW =>
          if w_Toggle = '0' and r_Toggle = '1' then -- Falling edge found
            r_SM_Main <= PATTERN_OFF;
          end if;

        when PATTERN_OFF =>
          if w_Toggle = '0' and r_Toggle = '1' then -- Falling edge found
            if o_Score = r_Index then
              r_Index   <= 0;
              r_SM_Main <= WAIT_PLAYER;
            else 
              r_Index   <= r_Index + 1;
              r_SM_Main <= PATTERN_SHOW;  
            end if;
          end if;

        when WAIT_PLAYER =>
          if r_Button_DV = '1' then
            if (r_Pattern(r_Index) = r_Button_ID and w_Index_SLV = o_Score) then
              r_SM_Main <= INCR_SCORE;
            elsif r_Pattern(r_Index) /= r_Button_ID then
              r_SM_Main <= IDLE;
            else
              r_Index <= r_Index + 1;
            end if;
        end if;

        -- Used to increment Score Counter
        when INCR_SCORE =>
          o_Score <= o_Score + 1;
          if to_integer(unsigned(o_Score)) = GAME_LIMIT then
            r_SM_Main <= WINNER;
          else
            r_SM_Main <= PATTERN_SHOW;
          end if;

        -- Display 0xAA on 7-Segment displays, stay here until new game starts
        when WINNER =>
          o_Score <= X"AA"; -- Winner!

        -- Display 0xEE on 7-Segment displays, stay here until new game starts
        when LOSER =>
          o_Score <= X"EE"; -- Loser!
        end

        when others =>
          r_SM_Main <= IDLE;
      end case;
    end if;
  end process;

  w_Index_SLV <= std_logic_vector(to_unsigned(r_Index, w_Index_SLV'length));

  -- Register in the LFSR to r_Pattern when game starts. 
  -- Each 2-bits of LFSR is one value for r_Pattern 2D Array.
  process (i_Clk) is
  begin
    if rising_edge(i_Clk) then
      if r_SM_Main = IDLE then
        r_Pattern(0)  <= w_LFSR_Data(1 downto 0);
        r_Pattern(1)  <= w_LFSR_Data(3 downto 2);
        r_Pattern(2)  <= w_LFSR_Data(5 downto 4);
        r_Pattern(3)  <= w_LFSR_Data(7 downto 6);
        r_Pattern(4)  <= w_LFSR_Data(9 downto 8);
        r_Pattern(5)  <= w_LFSR_Data(11 downto 10);
        r_Pattern(6)  <= w_LFSR_Data(13 downto 12);
        r_Pattern(7)  <= w_LFSR_Data(15 downto 14);
        r_Pattern(8)  <= w_LFSR_Data(17 downto 16);
        r_Pattern(9)  <= w_LFSR_Data(19 downto 18);
        r_Pattern(10) <= w_LFSR_Data(21 downto 20);
      end if;
    end if;
  end process;

  o_LED_1 <= '1' when (r_SM_Main = PATTERN_SHOW and r_Pattern(r_Index) = "00") else i_Switch_1;
  o_LED_2 <= '1' when (r_SM_Main = PATTERN_SHOW and r_Pattern(r_Index) = "01") else i_Switch_2;
  o_LED_3 <= '1' when (r_SM_Main = PATTERN_SHOW and r_Pattern(r_Index) = "10") else i_Switch_3;
  o_LED_4 <= '1' when (r_SM_Main = PATTERN_SHOW and r_Pattern(r_Index) = "11") else i_Switch_4;

  -- Create registers to enable falling edge detection
  process (i_Clk) is
  begin
    if rising_edge(i_Clk) then
      r_Toggle   <= w_Toggle;
      r_Switch_1 <= i_Switch_1;
      r_Switch_2 <= i_Switch_2;
      r_Switch_3 <= i_Switch_3;
      r_Switch_4 <= i_Switch_4;
      
      if r_Switch_1 = '1' and i_Switch_1 = '0' then
        r_Button_DV <= '1';
        r_Button_ID <= "00";
      elsif r_Switch_2 = '1' and i_Switch_2 = '0' then
        r_Button_DV <= '1';
        r_Button_ID <= "01";
      elsif r_Switch_3 = '1' and i_Switch_3 = '0' then
        r_Button_DV <= '1';
        r_Button_ID <= "10";
      elsif r_Switch_4 = '1' and i_Switch_4 = '0' then
        r_Button_DV <= '1';
        r_Button_ID <= "11";
      else
        r_Button_DV <= '0';
        r_Button_ID <= "00";
      end if;
    end if;
  end process;

  -- w_Count_En is high when state machine is in PATTERN_SHOW state or PATTERN_OFF state, else false
  w_Count_En <= '1' when (r_SM_Main = PATTERN_SHOW or r_SM_Main = PATTERN_OFF) else '0';

  Count_Inst : entity work.Count_And_Toggle 
  generic map (
    COUNT_LIMIT => CLKS_PER_SEC)
  port map (
    i_Clk    => i_Clk,
    i_Enable => w_Count_En,
    o_Toggle => w_Toggle);

  -- Generates 22-bit wide random data
  LFSR_Inst : entity work.LFSR_22
  port map (
    i_Clk       => i_Clk,
    o_LFSR_Data => w_LFSR_Data,
    o_LFSR_Done => open);  -- leave unconnected

end RTL;