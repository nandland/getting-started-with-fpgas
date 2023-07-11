-- Demonstrates various algebra equations and common pitfalls doing math in VHDL.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.env.finish;

entity Math_Examples is
end entity Math_Examples;

architecture test of Math_Examples is

  -- Takes input unsigned, returns string for printing
  function str(val : in unsigned) return string is
  begin
    return to_string(to_integer(val));
  end function str;
 
  -- Takes input signed, returns string for printing
  function str(val : in signed) return string is
  begin
    return to_string(to_integer(val));
  end function str;

  -- Takes input real, returns string for printing
  function str(val : in real) return string is
  begin
    return to_string(val, "%2.3f");
  end function str;

begin

  process is 
    variable i1_u4, i2_u4, o_u4 : unsigned(3 downto 0);
    variable i1_u5, i2_u5, o_u5 : unsigned(4 downto 0);
    variable i1_s4, i2_s4, o_s4 : signed(3 downto 0);
    variable i1_s5, i2_s5, o_s5 : signed(4 downto 0);
    variable i1_u6, i2_u6, o_u6 : unsigned(5 downto 0);
    variable i1_u8, i2_u8, o_u8 : unsigned(7 downto 0);
    variable i1_s8, i2_s8, o_s8 : signed(7 downto 0);
    variable real1, real2, real3 : real;
    
  begin
    
    -- Unsigned + Unsigned = Unsigned (Rule #1 violation)
    i1_u4 := "1001"; -- dec 9
    i2_u4 := "1011"; -- dec 11
    o_u4  := i1_u4 + i2_u4;
    report "Ex01: " & str(i1_u4) & " + " & str(i2_u4) & " = " & str(o_u4);

    -- Signed + Signed = Singed (Rule #1 violation)
    i1_s4 := "1001"; -- dec -7
    i2_s4 := "1011"; -- dec -5
    o_s4  := i1_s4 + i2_s4;
    report "Ex02: " & str(i1_s4) & " + " & str(i2_s4) & " = " & str(o_s4);
    
    -- Unsigned + Unsigned = Unsigned (Rule #1 Fix)
    i1_u4 := "1001"; -- dec 9
    i2_u4 := "1011"; -- dec 11
    i1_u5 := resize(i1_u4, i1_u5'length);
    i2_u5 := resize(i2_u4, i2_u5'length);
    o_u5  := i1_u5 + i2_u5;
    report "Ex03: " & str(i1_u5) & " + " & str(i2_u5) & " = " & str(o_u5);
    
    -- Signed + Signed = Signed (Rule #1 Fix)
    i1_s4 := "1001"; -- dec -7
    i2_s4 := "1011"; -- dec -5
    i1_s5 := resize(i1_s4, i1_s5'length);
    i2_s5 := resize(i2_s4, i2_s5'length);
    o_s5  := i1_s5 + i2_s5;
    report "Ex04: " & str(i1_s5) & " + " & str(i2_s5) & " = " & str(o_s5);
    
    -- Unsigned - Unsigned = Unsigned (bad)
    i1_u4 := "1001"; -- dec 9
    i2_u4 := "1011"; -- dec 11
    i1_u5 := resize(i1_u4, i1_u5'length);
    i2_u5 := resize(i2_u4, i2_u5'length);
    o_u5  := i1_u5 - i2_u5;
    report "Ex05: " & str(i1_u5) & " - " & str(i2_u5) & " = " & str(o_u5);
    
    -- Signed - Signed = Signed (fix)
    i1_u4 := "1001"; -- dec 9
    i2_u4 := "1011"; -- dec 11
    i1_s5 := signed(resize(i1_u4, i1_s5'length));
    i2_s5 := signed(resize(i2_u4, i2_s5'length));
    o_s5  := i1_s5 - i2_s5;
    report "Ex06: " & str(i1_s5) & " - " & str(i2_s5) & " = " & str(o_s5);

    -- Unsigned * Unsigned = Unsigned
    --i1_u4 := "1001"; -- dec 9
    --i2_u4 := "1011"; -- dec 11
    --o_u4  := i1_u4 * i2_u4;
    --report "Ex07: " & str(i1_u4) & " * " & str(i2_u4) & " = " & str(o_u4);

    -- Signed * Signed = Signed
    --i1_s4 := "1000"; -- dec -8
    --i2_s4 := "0111"; -- dec 7
    --o_s4  := i1_s4 * i2_s4;
    --report "Ex08: " & str(i1_s4) & " * " & str(i2_s4) & " = " & str(o_s4);

    -- Unsigned * Unsigned = Unsigned
    i1_u4 := "1001"; -- dec 9
    i2_u4 := "1011"; -- dec 11
    o_u8  := i1_u4 * i2_u4;
    report "Ex09: " & str(i1_u4) & " * " & str(i2_u4) & " = " & str(o_u8);
    
    -- Signed * Signed = Signed
    i1_s4 := "1000"; -- dec -8
    i2_s4 := "0111"; -- dec 7
    o_s8  := i1_s4 * i2_s4;
    report "Ex10: " & str(i1_s4) & " * " & str(i2_s4) & " = " & str(o_s8);

    -- Demonstrate: Multiply and Divide by base 2 numbers
    i1_u8 := to_unsigned(3, i1_u8'length);
    o_u8 := shift_left(i1_u8, 1);
    report "Ex11: " & str(i1_u8) & " * 2 = "  & str(o_u8);
    o_u8 := shift_left(i1_u8, 2);
    report "Ex12: " & str(i1_u8) & " * 4 = "  & str(o_u8);
    o_u8 := shift_left(i1_u8, 4);
    report "Ex13: " & str(i1_u8) & " * 16 = " & str(o_u8);

    i1_u8 := to_unsigned(128, i1_u8'length);
    o_u8 := shift_right(i1_u8, 1);
    report "Ex14: " & str(i1_u8) & " / 2 = "  & str(o_u8);
    o_u8 := shift_right(i1_u8, 2);
    report "Ex15: " & str(i1_u8) & " / 4 = "  & str(o_u8);
    o_u8 := shift_right(i1_u8, 4);
    report "Ex16: " & str(i1_u8) & " / 16 = " & str(o_u8);

    i1_u8 := to_unsigned(15, i1_u8'length);
    o_u8 := shift_right(i1_u8, 1);
    report "Ex17: " & str(i1_u8) & " / 2 = " & str(o_u8);
    o_u8 := shift_right(i1_u8, 2);
    report "Ex18: " & str(i1_u8) & " / 4 = " & str(o_u8);
    o_u8 := shift_right(i1_u8, 3);
    report "Ex19: " & str(i1_u8) & " / 8 = " & str(o_u8);

    -- Demonstrate: Modified Q Notation Examples
    -- U3.1 + U4.0 = U4.1 (Rule #5 violation)
    i1_u4 := "0011";
    i2_u4 := "0011";
    i1_u5 := resize(i1_u4, i1_u5'length);
    i2_u5 := resize(i2_u4, i2_u5'length);
    o_u5  := i1_u5 + i2_u5;

    real1 := real(to_integer(i1_u5)) / 2.0;
    real2 := real(to_integer(i2_u5));
    real3 := real(to_integer(o_u5)) / 2.0;
    report "Ex20: " & str(real1) & " + " & str(real2) & " = " & str(real3);

    -- Convert U3.1 to U4.0
    -- U4.0 + U4.0 = U5.0 (Rule #5 fix, using truncation)
    i1_u4 := "0011";
    i2_u4 := "0011";
    i1_u4 := shift_right(i1_u4, 1); -- Convert U3.1 to U4.0
    i1_u5 := resize(i1_u4, i1_u5'length);
    i2_u5 := resize(i2_u4, i2_u5'length);
    o_u5  := i1_u5 + i2_u5;
    
    real1 := real(to_integer(i1_u5));
    real2 := real(to_integer(i2_u5));
    real3 := real(to_integer(o_u5));
    report "Ex21: " & str(real1) & " + " & str(real2) & " = " & str(real3);
    
    -- Or Convert U4.0 to U4.1
    -- U3.1 + U4.1 = U5.1 (Rule #5 fix, using expansion)
    i1_u4 := "0011";
    i2_u4 := "0011";
    i1_u6 := resize(i1_u4, i1_u6'length); -- expand for adding
    i2_u6 := resize(i2_u5, i2_u6'length); -- expand for adding
    i2_u6 := shift_left(i2_u6, 1);  -- Convert 4.0 to 4.1
    o_u6  := i1_u6 + i2_u6;
    
    real1 := real(to_integer(i1_u6)) / 2.0;
    real2 := real(to_integer(i2_u6)) / 2.0;
    real3 := real(to_integer(o_u6)) / 2.0;
    report "Ex22: " & str(real1) & " + " & str(real2) & " = " & str(real3);

    
    -- Multiplication with Decimals
    -- U2.2 * U3.1 = U5.3
    i1_u4 := "0101";
    i2_u4 := "1011";
    o_u8  := i1_u4 * i2_u4;
    
    real1 := real(to_integer(i1_u4)) / 4.0;
    real2 := real(to_integer(i2_u4)) / 2.0;
    real3 := real(to_integer(o_u8))  / 8.0;
    report "Ex23: " & str(real1) & " * " & str(real2) & " = " & str(real3);

    -- S2.2 * S4.0 = U6.2
    i1_s4 := "0110";
    i2_s4 := "1010";
    o_s8  := i1_s4 * i2_s4;
    
    real1 := real(to_integer(i1_s4)) / 4.0;
    real2 := real(to_integer(i2_s4));
    real3 := real(to_integer(o_s8))  / 4.0;
    report "Ex24: " & str(real1) & " * " & str(real2) & " = " & str(real3);

    wait for 1 ns;
    finish;
    end process;
    
end test;