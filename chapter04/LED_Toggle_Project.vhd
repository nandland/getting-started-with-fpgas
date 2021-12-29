library ieee;
use ieee.std_logic_1164.all;
 
entity LED_Toggle_Project is
  port (
    i_Clk      : in  std_logic;
    i_Switch_1 : in  std_logic;
    o_LED_1    : out std_logic
    );
end entity LED_Toggle_Project;
 
architecture RTL of LED_Toggle_Project is
 
  signal r_LED_1    : std_logic := '0';
  signal r_Switch_1 : std_logic := '0';
   
begin
 
  -- Purpose: Toggle LED output when i_Switch_1 is released.
  process (i_Clk) is
  begin
    if rising_edge(i_Clk) then
      r_Switch_1 <= i_Switch_1;         -- Creates a Register
      
      -- This conditional expression looks for a falling edge on i_Switch_1.
      -- Here, the current value (i_Switch_1) is low, but the previous value
      -- (r_Switch_1) is high.  This means that we found a falling edge.
      if i_Switch_1 = '0' and r_Switch_1 = '1' then
        r_LED_1 <= not r_LED_1;       -- Toggle LED output
      end if;
    end if;
  end process;
 
  o_LED_1 <= r_LED_1;
 
end architecture RTL;
