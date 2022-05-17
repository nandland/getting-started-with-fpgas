-- Testbench for Debounce Filter
library ieee;
use ieee.std_logic_1164.all;
use std.env.finish;

entity Mux_4_To_1_TB is
end entity Mux_4_To_1_TB;
 
architecture test of Mux_4_To_1_TB is
  signal r_In1, r_In2, r_In3, r_In4 : std_logic;
  signal r_Sel1, r_Sel2, w_Out : std_logic;
begin
  UUT : entity work.Mux_4_To_1 
    port map (
      .in1  => r_In1,
      in2  => r_In2,
      in3  => r_In3,
      in4  => r_In4,
      sel1  => r_Sel1,
      o_Debounced => w_Debounced); 
   
  process is 
  begin
    wait for 12 ns;
    r_Bouncy <= '1';  -- toggle state of input pin
      
    wait until rising_edge(r_Clk);
    r_Bouncy <= '0';  -- simulate a glitch/bounce of switch
    
    wait until rising_edge(r_Clk);
    r_Bouncy <= '1';  -- bounce goes away
    
    wait for 24 ns;
    finish;  -- need VHDL-2008
  end process;
end test;


Mux_4_To_1 UUT (.in1(r_In1), .in2(r_In2), .in3(r_In3), .in4(r_In4),
                .sel1(r_Sel1), .sel2(r_Sel2), .out(w_Out));

// Takes input integer and drives select inputs
task set_select(input reg [1:0] sel);
  #1;
  r_Sel1 = sel[1];
  r_Sel2 = sel[0];
  #1;
endtask


initial 
begin
  set_select(0);
  assert (w_Out == r_In1);
  set_select(1);
  assert (w_Out == r_In2);
  set_select(2);
  assert (w_Out == r_In3);
  set_select(3);
  assert (w_Out == r_In4);
  $finish();
end

endmodule
