-- Top of Mux Demonstration
-- Instantiates 4 LED blinkers at different frequencies
-- User can select which one to output by using S1 and S2
-- Demonstrates muxing of any of these to a single LED output (o_LED_1)

library ieee;
use ieee.std_logic_1164.all;

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