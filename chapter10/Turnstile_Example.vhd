library ieee;
use ieee.std_logic_1164.all;

entity Turnstile_Example is
  port (
    i_Reset  : in std_logic;
    i_Clk    : in std_logic;
    i_Coin   : in std_logic;
    i_Push   : in std_logic;
    o_Locked : out std_logic);
end entity Turnstile_Example;

architecture RTL of Turnstile_Example is

  type t_State is (LOCKED, UNLOCKED); 
  signal r_Curr_State, r_Next_State : t_State;

begin

  -- Current State Register
 -- process (i_Clk, i_Reset) is
 -- begin
 --   if (i_Reset) then
 --     r_Curr_State <= LOCKED;
 --   elsif rising_edge(i_Clk) then
 --     r_Curr_State <= r_Next_State;
 --   end if;
 -- end process;
--
 -- -- Next State Determination
 -- process (r_Curr_State, i_Coin, i_Push)
 -- begin
 --   r_Next_State <= r_Curr_State;
--
 --   case r_Curr_State is 
 --     
 --     when LOCKED =>
 --       if i_Coin = '1' then
 --         r_Next_State <= UNLOCKED;
 --       end if;
--
 --     when UNLOCKED =>
 --       if i_Push = '1' then
 --         r_Next_State <= LOCKED;
 --       end if;
--
 --   end case;
 -- end process;

  
  -- Single always block approach
  process (i_Clk, i_Reset) is
  begin
    if (i_Reset) then
      r_Curr_State <= LOCKED;
    elsif rising_edge(i_Clk) then
  
      case r_Curr_State is 
      
        when LOCKED =>
          if i_Coin = '1' then
            r_Curr_State <= UNLOCKED;
          end if;
  
        when UNLOCKED =>
          if i_Push = '1' then
            r_Curr_State <= LOCKED;
          end if;
  
      end case;
    end if;
  end process;

  o_Locked <= '1' when r_Curr_State = LOCKED else '0';

end RTL;