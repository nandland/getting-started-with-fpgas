-- Top of Demux and LFSR Demonstration
-- Instantiates an LFSR, which generates a ~1 second toggling signal
-- 
-- User can select which LED is illuminated with this toggling signal 
-- by using using S1 and S2 to drive select bits of a demux.
-- Demonstrates demuxing of this toggling signal to one of 4 LED outputs.
-- 
-- LFSR takes 2^22-1 clock cycles to run through all its combinations
-- Pulses w_LFSR_Done each time it completes
-- We take done pulse and use that to toggle the LED drive signal.
-- The toggling signal can be muxed to each LED output

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
    
  signal r_LFSR_Toggle : std_logic := '0';
  signal w_LFSR_Done : std_logic;

begin

  LFSR_22 : entity work.LFSR_22
  port map (
    i_Clk       => i_Clk,
    o_LFSR_Data => open, -- unconnected
    o_LFSR_Done => w_LFSR_Done);

  process (i_Clk) is 
  begin
    if rising_edge(i_Clk) then
        if w_LFSR_Done = '1' then
            r_LFSR_Toggle <= not r_LFSR_Toggle;
        end if;
    end if;
  end process;

  Demux_Inst : entity work.Demux_1_To_4
  port map (
    i_Data  => r_LFSR_Toggle,
    i_Sel0  => i_Switch_1,
    i_Sel1  => i_Switch_2,
    o_Data0 => o_LED_1,
    o_Data1 => o_LED_2,
    o_Data2 => o_LED_3,
    o_Data3 => o_LED_4);

end architecture RTL;
