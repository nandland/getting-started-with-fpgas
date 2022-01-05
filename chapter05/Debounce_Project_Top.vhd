-- Top level file for adding a Debounce filter to LED toggling
-- Instantiates the Debounce Filter and the LED toggle modules

library ieee;
use ieee.std_logic_1164.all;
 
entity Debounce_Project_Top is
  port (
    i_Clk       : in  std_logic;
    i_Switch_1  : in  std_logic;
    o_LED_1     : out std_logic
    );
end entity Debounce_Project_Top;
 
architecture RTL of Debounce_Project_Top is
 
  signal w_Debounced_Switch : std_logic;
   
begin

  -- Instantiate Debounce Filter
  Debounce_Inst : entity work.Debounce_Filter
    port map (
      i_Clk       => i_Clk,
      i_Bouncy    => i_Switch_1,
      o_Debounced => w_Debounced_Switch);
  
  -- Instantiate LED Toggle
  LED_Toggle_Inst : entity work.LED_Toggle_Project
    port map (
      i_Clk      => i_Clk,
      i_Switch_1 => w_Debounced_Switch,
      o_LED_1    => o_LED_1);

end architecture RTL;
