-- Simple testbench to verify Demux functionality

library ieee;
use ieee.std_logic_1164.all;
use std.env.finish;

entity Demux_1_To_4_TB is
end entity Demux_1_To_4_TB;
 
architecture test of Demux_1_To_4_TB is
  signal r_Data : std_logic := '1';
  signal w_Data0, w_Data1, w_Data2, w_Data3 : std_logic;
  signal r_Sel1, r_Sel0 : std_logic;

begin
  UUT : entity work.Demux_1_To_4 
    port map (
      i_Data  => r_Data,
      i_Sel0  => r_Sel0,
      i_Sel1  => r_Sel1,
      o_Data0 => w_Data0,
      o_Data1 => w_Data1,
      o_Data2 => w_Data2,
      o_Data3 => w_Data3); 
   
  process is 
  begin
    wait for 1 ns;
    r_Sel0 <= '0';
    r_Sel1 <= '0';
    wait for 1 ns;
    assert (w_Data0) report "Data not expected" severity failure;
    assert (not w_Data1) report "Data not expected" severity failure;
    assert (not w_Data2) report "Data not expected" severity failure;
    assert (not w_Data3) report "Data not expected" severity failure;

    wait for 1 ns;
    r_Sel0 <= '1';
    r_Sel1 <= '0';
    wait for 1 ns;
    assert (not w_Data0) report "Data not expected" severity failure;
    assert (w_Data1) report "Data not expected" severity failure;
    assert (not w_Data2) report "Data not expected" severity failure;
    assert (not w_Data3) report "Data not expected" severity failure;
    
    wait for 1 ns;
    r_Sel0 <= '0';
    r_Sel1 <= '1';
    wait for 1 ns;
    assert (not w_Data0) report "Data not expected" severity failure;
    assert (not w_Data1) report "Data not expected" severity failure;
    assert (w_Data2) report "Data not expected" severity failure;
    assert (not w_Data3) report "Data not expected" severity failure;
    
    wait for 1 ns;
    r_Sel0 <= '1';
    r_Sel1 <= '1';
    wait for 1 ns;
    assert (not w_Data0) report "Data not expected" severity failure;
    assert (not w_Data1) report "Data not expected" severity failure;
    assert (not w_Data2) report "Data not expected" severity failure;
    assert (w_Data3) report "Data not expected" severity failure;
    
    finish;  -- need VHDL-2008
  end process;
end test;