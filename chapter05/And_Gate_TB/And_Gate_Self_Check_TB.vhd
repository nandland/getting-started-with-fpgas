-- Simple testbench to exercise the And_Gate_Project
library IEEE;
use IEEE.std_logic_1164.all;
use std.env.finish;

entity And_Gate_TB is
end entity And_Gate_TB;

architecture behave of And_Gate_TB is
  signal r_In1, r_In2, w_Out : std_logic;

begin
 
  -- Here is where we instantiate the UUT
  UUT : entity work.And_Gate_Project
  port map (
    i_Switch_1 => r_In1,
    i_Switch_2 => r_In2,
    o_LED_1    => w_Out);
  
  -- The steps to exercise the UUT go here
  process is 
  begin
  	r_In1 <= '0';
    r_In2 <= '0';
    wait for 10 ns;
    assert (w_Out = '0') severity failure;
    
    r_In1 <= '0';
    r_In2 <= '1';
    wait for 10 ns;
    assert (w_Out = '0') severity failure;

    r_In1 <= '1';
    r_In2 <= '0';
    wait for 10 ns;
    assert (w_Out = '0') severity failure;

    r_In1 <= '1';
    r_In2 <= '1';
    wait for 10 ns;
    assert (w_Out = '1') severity failure;
    wait for 10 ns;
    wait for 10 ns;
    finish;
  end process;
  

end behave;
