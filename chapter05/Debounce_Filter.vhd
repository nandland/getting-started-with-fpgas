library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity Debounce_Switch is
  port (
    i_Clk    : in  std_logic;
    i_Switch : in  std_logic;
    o_Switch : out std_logic
    );
end entity Debounce_Switch;
 
architecture RTL of Debounce_Switch is
 
  -- Set for 250,000 clock ticks of 25 MHz clock (10 ms)
  -- TODO: TURN THIS INTO A GENERIC
  constant c_DEBOUNCE_LIMIT : integer := 250000;
 
  signal r_Count : integer range 0 to c_DEBOUNCE_LIMIT := 0;
  signal r_State : std_logic := '0';
 
begin
 
  p_Debounce : process (i_Clk) is
  begin
    if rising_edge(i_Clk) then
 
      -- Switch input is different than internal switch value, so an input is
      -- changing.  Increase counter until it is stable for c_DEBOUNCE_LIMIT.
      if (i_Switch /= r_State and r_Count < c_DEBOUNCE_LIMIT) then
        r_Count <= r_Count + 1;
 
      -- End of counter reached, switch is stable, register it, reset counter
      elsif r_Count = c_DEBOUNCE_LIMIT then
        r_State <= i_Switch;
        r_Count <= 0;
 
      -- Switches are the same state, reset the counter
      else
        r_Count <= 0;
 
      end if;
    end if;
  end process p_Debounce;
 
  -- Assign internal register to output (debounced!)
  o_Switch <= r_State;
 
end architecture RTL;
