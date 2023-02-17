-- Counts up to COUNT_LIMIT clock cycles when i_Enable is high.
-- When COUNT_LIMIT clocs occur, will toggle o_Toggle output. 
-- Can reset the state of o_Toggle to 0 by disabling i_Enable

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity Count_And_Toggle is
  generic (
    COUNT_LIMIT : natural);
  port (
    i_Clk    : in  std_logic;
    i_Enable : in  std_logic;
    o_Toggle : out std_logic);
end Count_And_Toggle;
 
architecture RTL of Count_And_Toggle is
 
  -- Create the signal to do the actual counting
  -- Subtract 1, since counter starts at 0
  signal r_Counter : natural range 0 to COUNT_LIMIT - 1;

begin
 
  -- This process toggles the output at desired frequency   
  process (i_Clk) is
  begin
    if rising_edge(i_Clk) then
      if i_Enable = '1' then
        if r_Counter = COUNT_LIMIT - 1 then
          o_Toggle  <= not o_Toggle;
          r_Counter <= 0;
       else
         r_Counter <= r_Counter + 1;
       end if;
      else
        o_Toggle  <= '0';
        r_Counter <= 0;
      end if;
    end if;
  end process;
 
end RTL;