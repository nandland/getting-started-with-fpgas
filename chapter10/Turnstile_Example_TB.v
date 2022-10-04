module Turnstile_Example_TB();

  reg r_Reset = 1'b1, r_Clk = 1'b0, r_Coin = 1'b0, r_Push = 1'b0;
  wire w_Locked;

  Turnstile_Example 
   (.i_Reset(r_Reset),
    .i_Clk(r_Clk), 
    .i_Coin(r_Coin),
    .i_Push(r_Push),
    .o_Locked(w_Locked));
  
  always #1 r_Clk <= !r_Clk;

  initial begin
    #10;
    r_Reset <= 1'b0;
    #10;
    r_Coin <= 1'b1;
    #10;
    r_Push <= 1'b1;
    #10;
    r_Coin <= 1'b0;
    #10;
    r_Push <= 1'b0;
    #10;
  end

endmodule