module Turnstile_Example
 (input i_Reset,
  input i_Clk, 
  input i_Coin,
  input i_Push,
  output o_Locked);

  localparam LOCKED   = 1'b0;
  localparam UNLOCKED = 1'b1;

  reg r_Curr_State, r_Next_State;

/*
  // Current State Register
  always @(posedge i_Clk or posedge i_Reset)
  begin
    if (i_Reset)
      r_Curr_State <= LOCKED;
    else
      r_Curr_State <= r_Next_State;
  end

  // Next State Determination
  always @(r_Curr_State or i_Coin or i_Push)
  begin
    r_Next_State <= r_Curr_State;

    case (r_Curr_State)

      LOCKED:
        if (i_Coin)
          r_Next_State <= UNLOCKED;
      
      UNLOCKED:
        if (i_Push)
          r_Next_State <= LOCKED;

    endcase
  end
*/

  // Single always block approach
  always @(posedge i_Clk or posedge i_Reset)
  begin
    if (i_Reset)
      r_Curr_State <= LOCKED;
    else
    begin
      case (r_Curr_State)
      
        LOCKED: 
          if (i_Coin)
            r_Curr_State <= UNLOCKED;
          
        UNLOCKED:
          if (i_Push)
            r_Curr_State <= LOCKED;

      endcase
    end
  end


  assign o_Locked = (r_Curr_State == LOCKED);

endmodule