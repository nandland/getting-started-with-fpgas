-- This module is used to debounce any switch or button coming into the FPGA.
-- Does not allow the output to change unless the input i_Bouncy is
-- steady for enough time (not toggling).
--
-- Generics: 
-- DEBOUNCE_LIMIT - Determines number of clock cycles that input must be stable
--                  before output is updated. 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity Debounce_Filter is
  generic (DEBOUNCE_LIMIT : integer := 20);
  port (
    i_Clk       : in  std_logic;
    i_Bouncy    : in  std_logic;
    o_Debounced : out std_logic
    );
end entity Debounce_Filter;
 
architecture RTL of Debounce_Filter is
  
  signal r_Count : integer range 0 to DEBOUNCE_LIMIT := 0;
  signal r_State : std_logic := '0';
 
begin
 
  process (i_Clk) is
  begin
    if rising_edge(i_Clk) then
 
      -- Switch input is different than internal switch value, so an input is
      -- changing.  Increase counter until it is stable for DEBOUNCE_LIMIT.
      if (i_Bouncy /= r_State and r_Count < DEBOUNCE_LIMIT) then
        r_Count <= r_Count + 1;
 
      -- End of counter reached, switch is stable, register it, reset counter
      elsif r_Count = DEBOUNCE_LIMIT then
        r_State <= i_Bouncy;
        r_Count <= 0;
 
      -- Switches are the same state, reset the counter
      else
        r_Count <= 0;
 
      end if;
    end if;
  end process;
 
  -- Assign internal register to output (debounced!)
  o_Debounced <= r_State;
 
end architecture RTL;
