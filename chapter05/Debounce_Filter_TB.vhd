-- Testbench for Debounce Filter
library ieee;
use ieee.std_logic_1164.all;
use std.env.finish;

entity Debounce_Filter_TB is
end entity Debounce_Filter_TB;
 
architecture test of Debounce_Filter_TB is
  signal r_Clk, r_Bouncy, w_Debounced : std_logic := '0';
begin
  r_Clk <= not r_Clk after 2 ns;
  
  UUT : entity work.Debounce_Filter 
    generic map (DEBOUNCE_LIMIT => 4)
    port map (
      i_Clk       => r_Clk,
      i_Bouncy    => r_Bouncy,
      o_Debounced => w_Debounced); 
   
  process is 
  begin
    wait for 10 ns;
    r_Bouncy <= '1';  -- toggle state of input pin
      
    wait until rising_edge(r_Clk);
    r_Bouncy <= '0';  -- simulate a glitch/bounce of switch
    
    wait until rising_edge(r_Clk);
    r_Bouncy <= '1';  -- bounce goes away
    
    wait for 24 ns;
    finish;  -- need VHDL-2008
  end process;
end test;
