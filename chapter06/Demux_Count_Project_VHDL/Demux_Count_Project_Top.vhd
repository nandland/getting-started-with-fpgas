-- Top of Demux and Count Demonstration
-- Instantiates a Counter, which generates a ~1 second toggling signal
-- 
-- User can select which LED is illuminated with this toggling signal 
-- by using using S1 and S2 to drive select bits of a demux.
-- Demonstrates demuxing of this toggling signal to one of 4 LED outputs.

library ieee;
use ieee.std_logic_1164.all;

entity Demux_LFSR_Project_Top is 
  port (
    i_Clk      : in  std_logic;
    i_Switch_1 : in  std_logic;
    i_Switch_2 : in  std_logic;
    o_LED_1    : out std_logic;
    o_LED_2    : out std_logic;
    o_LED_3    : out std_logic;
    o_LED_4    : out std_logic);
end entity Demux_LFSR_Project_Top;   

architecture RTL of Demux_LFSR_Project_Top is
    
  -- Equilalent to 2^22 - 1, which is what the LFSR counted up to
  constant COUNT_LIMIT : integer := 4194303;

  signal w_Counter_Toggle : std_logic;

begin

  Toggle_Counter : entity work.Count_And_Toggle 
  generic map (
    COUNT_LIMIT => COUNT_LIMIT)
  port map (
    i_Clk    => i_Clk,
    i_Enable => '1',
    o_Toggle => w_Counter_Toggle);
   
  Demux_Inst : entity work.Demux_1_To_4
  port map (
    i_Data  => w_Counter_Toggle,
    i_Sel0  => i_Switch_1,
    i_Sel1  => i_Switch_2,
    o_Data0 => o_LED_1,
    o_Data1 => o_LED_2,
    o_Data2 => o_LED_3,
    o_Data3 => o_LED_4);

end architecture RTL;
