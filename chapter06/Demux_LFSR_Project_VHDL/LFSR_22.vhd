-- 22 bit wide LFSR
library IEEE;
use IEEE.std_logic_1164.all;

entity LFSR_22 is 
  port (
    i_Clk       : in std_logic;
    o_LFSR_Data : out std_logic_vector(21 downto 0);
    o_LFSR_Done : out std_logic);
end entity LFSR_22;

architecture RTL of LFSR_22 is

signal r_LFSR : std_logic_vector(21 downto 0);
signal w_XNOR : std_logic;

begin

  process (i_Clk) begin
    if rising_edge (i_Clk) then
      r_LFSR <= r_LFSR(20 downto 0) & w_XNOR;
    end if;
  end process;

w_XNOR      <= r_LFSR(21) xnor r_LFSR(20);
o_LFSR_Done <= '1' when (r_LFSR = "0000000000000000000000") else '0';
o_LFSR_Data <= r_LFSR;

end RTL;
