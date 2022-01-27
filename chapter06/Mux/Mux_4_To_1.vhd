library ieee;
use ieee.std_logic_1164.all;
 
entity Mux_4_To_1 is
  port (
    in1  : in  std_logic;
    in2  : in  std_logic;
    in3  : in  std_logic;
    in4  : in  std_logic;
    sel1 : in  std_logic;
    sel2 : in  std_logic;
    out1 : out std_logic);
end entity Mux_4_To_1;
 
architecture RTL of Mux_4_To_1 is
begin
  
  out1 <= in1 when sel1 = '0' and sel2 = '0' else
          in2 when sel1 = '0' and sel2 = '1' else
          in3 when sel1 = '1' and sel2 = '0' else
          in4;
    
end architecture RTL;