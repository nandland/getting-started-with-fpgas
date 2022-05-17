-- Simple testbench to verify Mux functionality
library ieee;
use ieee.std_logic_1164.all;
use std.env.finish;

entity Mux_4_To_1_TB is
end entity Mux_4_To_1_TB;
 
architecture test of Mux_4_To_1_TB is
  signal r_Data0, r_Data1, r_Data2, r_Data3 : std_logic := '0';
  signal r_Sel1, r_Sel0, w_Out : std_logic;

begin
  UUT : entity work.Mux_4_To_1 
    port map (
      i_Data0  => r_Data0,
      i_Data1  => r_Data1,
      i_Data2  => r_Data2,
      i_Data3  => r_Data3,
      i_Sel0   => r_Sel0,
      i_Sel1   => r_Sel1,
      o_Data  =>  w_Out); 
   
  process is 
  begin
    wait for 1 ns;
    r_Sel0 <= '0';
    r_Sel1 <= '0';
    wait for 1 ns;
    assert (w_Out = r_Data0) report "Data not expected" severity failure;

    wait for 1 ns;
    r_Sel0 <= '1';
    r_Sel1 <= '0';
    wait for 1 ns;
    assert (w_Out = r_Data1) report "Data not expected" severity failure;
    
    wait for 1 ns;
    r_Sel0 <= '0';
    r_Sel1 <= '1';
    wait for 1 ns;
    assert (w_Out = r_Data2) report "Data not expected" severity failure;
    
    wait for 1 ns;
    r_Sel0 <= '1';
    r_Sel1 <= '1';
    wait for 1 ns;
    assert (w_Out = r_Data3) report "Data not expected" severity failure;
    
    finish;  -- need VHDL-2008
  end process;
end test;