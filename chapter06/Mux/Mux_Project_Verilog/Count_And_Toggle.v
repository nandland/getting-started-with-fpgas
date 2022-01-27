// Counts up to COUNT_LIMIT clock cycles when i_Enable is high.
// When COUNT_LIMIT clocs occur, will toggle o_Toggle output. 
// Can reset the state of o_Toggle to 0 by disabling i_Enable

module Count_And_Toggle #(COUNT_LIMIT = 10)
   (input i_Clk,
    input i_Enable,
    output o_Toggle);
    
  // Create the signal to do the actual counting
  // Subtract 1, since counter starts at 0
  reg [$clog2(COUNT_LIMIT-1):0] r_Counter;

begin
 
  // This always block toggles the output at desired frequency   
  always @(posedge i_Clk) 
  begin
    if (i_Enable == 1'b1)
    begin
      if (r_Counter == COUNT_LIMIT - 1)
      begin
        o_Toggle  <= !o_Toggle;
        r_Counter <= 0;
      end
      else
        r_Counter <= r_Counter + 1;
    end
    else
      o_Toggle <= 1'b0;
  end
  
end

endmodule
