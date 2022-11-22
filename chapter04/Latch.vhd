library ieee;
use ieee.std_logic_1164.all;
 
entity Latch is
  port (
    i_A : in  std_logic;
    i_B : in  std_logic;
    o_Q : out std_logic
    );
end entity Latch;
 
architecture RTL of Latch is
 
begin
 
  process (i_A, i_B)
  begin
    if i_A = '0' and i_B = '0' then
      o_Q <= '0';
    elsif i_A = '0' and i_B = '1' then
      o_Q <= '1';
    elsif i_A = '1' and i_B = '0' then
      o_Q <= '1';
    -- Missing one last ELSE statement! 
    end if;
  end process;

end architecture RTL;
