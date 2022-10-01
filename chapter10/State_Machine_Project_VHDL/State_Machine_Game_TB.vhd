-- Testbench of State Machine Game
-- Simple tests to ensure that state machine works

library ieee;
use ieee.std_logic_1164.all;
use std.env.finish;

entity State_Machine_Game_TB is
end State_Machine_Game_TB;

architecture test of State_Machine_Game_TB is
  constant CLKS_PER_SEC : integer := 6;
  constant GAME_LIMIT   : integer := 3;
  signal r_Clk : std_logic := '0';
  signal r_Sw_1, r_Sw_2, r_Sw_3, r_Sw_4 : std_logic := '0';
  signal w_LED_1, w_LED_2, w_LED_3, w_LED_4 : std_logic;
  signal w_Score : std_logic_vector(3 downto 0);

  -- Sets switches to desired value for one clock cycle, 
  -- then drives back to 0.
  procedure set_switches (
    constant i_1, i_2, i_3, i_4 : in std_logic;
    signal   o_1, o_2, o_3, o_4 : out std_logic) is
  begin
    wait until rising_edge(r_Clk);
    o_1 <= i_1;
    o_2 <= i_2;
    o_3 <= i_3;
    o_4 <= i_4;
    wait until rising_edge(r_Clk);
    o_1 <= '0';
    o_2 <= '0';
    o_3 <= '0';
    o_4 <= '0';
    wait until rising_edge(r_Clk);
  end set_switches;

begin

  r_Clk <= not r_Clk after 10 ns;
  
  Game_Inst : entity work.State_Machine_Game
    generic map (
      CLKS_PER_SEC => CLKS_PER_SEC,
      GAME_LIMIT   => GAME_LIMIT) 
    port map ( 
      i_Clk      => r_Clk,
      i_Switch_1 => r_Sw_1,
      i_Switch_2 => r_Sw_2,
      i_Switch_3 => r_Sw_3,
      i_Switch_4 => r_Sw_4,
      o_Score    => w_Score,
      o_LED_1    => w_LED_1,
      o_LED_2    => w_LED_2,
      o_LED_3    => w_LED_3,
      o_LED_4    => w_LED_4);
  
  process is
  begin
    set_switches('0', '0', '0', '0', r_Sw_1, r_Sw_2, r_Sw_3, r_Sw_4);
    wait for 180 ns;
    set_switches('1', '1', '0', '0', r_Sw_1, r_Sw_2, r_Sw_3, r_Sw_4);
    wait for 180 ns;
    set_switches('0', '0', '0', '1', r_Sw_1, r_Sw_2, r_Sw_3, r_Sw_4);
    wait for 180 ns;
    set_switches('0', '0', '0', '1', r_Sw_1, r_Sw_2, r_Sw_3, r_Sw_4);
    wait for 180 ns;
    set_switches('0', '0', '0', '1', r_Sw_1, r_Sw_2, r_Sw_3, r_Sw_4);
    wait for 180 ns;
    
    -- Reset game back to start
    set_switches('1', '1', '0', '0', r_Sw_1, r_Sw_2, r_Sw_3, r_Sw_4);
    wait for 60 ns;
   
    finish;  -- need VHDL-2008
  end process;
   
end test;
