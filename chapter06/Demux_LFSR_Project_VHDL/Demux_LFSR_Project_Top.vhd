-- Top of Demux and LFSR Demonstration
-- Instantiates an LFSR, which generates a ~1 second toggling signal
-- 
-- User can select which LED is illuminated with this toggling signal 
-- by using using S1 and S2 to drive select bits of a demux.
-- Demonstrates demuxing of any of these to a single LED output (o_LED_1)
-- 
-- LFSR takes 2^22-1 clock cycles to run through all its combinations
-- Pulses w_Slow_Pulse each time it completes
-- We take slow pulse and use that to toggle the LED drive signal.
-- The toggling signal can be muxed to each LED output
-- 
-- For resource comparison, you can try removing the LFSR and instead
-- uncommenting the traditional counter.

library ieee;
use ieee.std_logic_1164.all;

entity Demux_Project_Top is 
  port (
    i_Clk      : in  std_logic;
    i_Switch_1 : in  std_logic;
    i_Switch_2 : in  std_logic;
    o_LED_1    : out std_logic;
    o_LED_2    : out std_logic;
    o_LED_3    : out std_logic;
    o_LED_4    : out std_logic);
end entity Demux_Project_Top;   

architecture RTL of Demux_Project_Top is
    
  -- LFSR takes 2^22-1 (4,194,303) clock cycles to complete
  constant NUM_LFSR_BITS : integer := 22;

  -- Set to 1 to use LFSR, set to 0 to use Counter
  constant USE_LFSR : integer := 1;
   
  signal r_LFSR_Toggle : std_logic := '0';
  signal w_Slow_Pulse : std_logic;
  signal w_LED_Toggle, w_Counter_Toggle : std_logic;
  
  Toggle_LFSR : entity work.LFSR 
  generic map (
    NUM_BITS => NUM_LFSR_BITS)
  port map (
    i_Clk       => i_Clk,
    i_Enable    => '1',
    i_Seed_DV   => '0',
    i_Seed_Data => 0,
    o_LFSR_Data => open, -- unconnected
    o_LFSR_Done => w_Slow_Pulse);

  process (i_Clk) is 
  begin
    if rising_edge(i_Clk) then
        if w_Slow_Pulse = '1' then
            r_LFSR_Toggle <= not r_LFSR_Toggle;
    end
  end

  Toggle_Counter : entity work.Count_And_Toggle 
  generic map (
    COUNT_LIMIT => 2**NUM_LFSR_BITS)
  port map (
    i_Clk    => i_Clk,
    i_Enable => '1',
    o_Toggle => w_Counter_Toggle);
   
  w_LED_Toggle <= r_LFSR_Toggle when USE_LFSR = 1 else w_Counter_Toggle;

  Demux_Inst : entity work.Demux_1_To_4
  port map (
    i_Data  => w_LED_Toggle,
    i_Sel0  => i_Switch_1,
    i_Sel1  => i_Switch_2,
    o_Data0 => o_LED_1,
    o_Data1 => o_LED_2,
    o_Data2 => o_LED_3,
    o_Data3 => o_LED_4);

endmodule

-- Top of Mux Demonstration
-- Instantiates 4 LED blinkers at different frequencies
-- User can select which one to output by using S1 and S2
-- Demonstrates muxing of any of these to a single LED output (o_LED_1)



entity Mux_Project_Top is
    port (
        i_Clk      : in  std_logic;
        i_Switch_1 : in  std_logic;
        i_Switch_2 : in  std_logic;
        o_LED_1    : out std_logic);
end entity Mux_Project_Top;

architecture RTL of Mux_Project_Top is

    signal w_Toggle_1Hz, w_Toggle_2Hz, w_Toggle_5Hz, w_Toggle_10Hz : std_logic;

begin
    
    Toggle_1Hz : entity work.Count_And_Toggle 
    generic map (
        COUNT_LIMIT => 25000000/2)
    port map (
        i_Clk    => i_Clk,
        i_Enable => '1',
        o_Toggle => w_Toggle_1Hz);

    Toggle_2Hz : entity work.Count_And_Toggle 
    generic map (
        COUNT_LIMIT => 25000000/4)
    port map (
        i_Clk    => i_Clk,
        i_Enable => '1',
        o_Toggle => w_Toggle_2Hz);

    Toggle_5Hz : entity work.Count_And_Toggle 
    generic map (
        COUNT_LIMIT => 25000000/10)
    port map (
        i_Clk    => i_Clk,
        i_Enable => '1',
        o_Toggle => w_Toggle_5Hz);
        
    Toggle_10Hz : entity work.Count_And_Toggle 
    generic map (
        COUNT_LIMIT => 25000000/20)
    port map (
        i_Clk    => i_Clk,
        i_Enable => '1',
        o_Toggle => w_Toggle_10Hz);

    Mux_4_To_1_Inst : entity work.Mux_4_To_1
    port map (
        in1  => w_Toggle_1Hz,
        in2  => w_Toggle_2Hz,
        in3  => w_Toggle_5Hz, 
        in4  => w_Toggle_10Hz,
        sel1 => i_Switch_1,
        sel2 => i_Switch_2,
        out1 => o_LED_1);
          

end architecture RTL;