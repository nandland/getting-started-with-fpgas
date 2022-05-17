library ieee;
use ieee.std_logic_1164.all;
 
entity Mux_4_To_1 is
  port (
    i_Data0 : in  std_logic;
    i_Data1 : in  std_logic;
    i_Data2 : in  std_logic;
    i_Data3 : in  std_logic;
    i_Sel0  : in  std_logic;
    i_Sel1  : in  std_logic;
    o_Data  : out std_logic);
end entity Mux_4_To_1;
 
architecture RTL of Mux_4_To_1 is
begin
  
  o_Data <= i_Data0 when i_Sel1 = '0' and i_Sel0 = '0' else
            i_Data1 when i_Sel1 = '0' and i_Sel0 = '1' else
            i_Data2 when i_Sel1 = '1' and i_Sel0 = '0' else
            i_Data3;
    
end architecture RTL;