module Latch
 (input  i_A,
  input  i_B,
  output reg o_Q);

  always @ (i_A or i_B)
  begin
    if (i_A == 1'b0 && i_B == 1'b0)
      o_Q <= 1'b0;
    else if (i_A == 1'b0 && i_B == 1'b1)
      o_Q <= 1'b1;
    else if (i_A == 1'b1 && i_B == 1'b0)
      o_Q <= 1'b1;
    // Missing one last ELSE statement!
  end
endmodule
