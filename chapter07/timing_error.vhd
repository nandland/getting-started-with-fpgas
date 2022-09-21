library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity timing_error is 
  port (
    i_Clk  : in  std_logic;
    i_Data : in  unsigned(7 downto 0);
    o_Data : out unsigned(15 downto 0));
end entity timing_error;

architecture RTL of timing_error is
  signal r0_Data, r1_Data, r2_Data : unsigned(7 downto 0);
begin

  process (i_Clk) is
  begin
    if rising_edge(i_Clk) then
      -- Register so tools know r0_Data
      -- is in i_Clk clock domain.
      r0_Data <= i_Data;
  
      -- BAD: Long propagation delay
      --o_Data <= ((r0_Data / 3) + 1) * 5;
  
      -- FIX: Pipeline math operations
      r1_Data <= r0_Data / 3;
      r2_Data <= r1_Data + 1;
      o_Data  <= r2_Data * 5;  
    end if;
  end process;

end RTL;
