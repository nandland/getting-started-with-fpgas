module LED_Toggle_Project(
    input  i_Clk,
    input  i_Switch_1,
    output o_LED_1);
                             
    reg r_LED_1    = 1'b0;
    reg r_Switch_1 = 1'b0;
 
    // Purpose: Toggle LED output when i_Switch_1 is released.
    always @(posedge i_Clk)
    begin
        r_Switch_1 <= i_Switch_1;  // Creates a Register
 
        // This conditional expression looks for a falling edge on i_Switch_1.
        // Here, the current value (i_Switch_1) is low, but the previous value
        // (r_Switch_1) is high.  This means that we found a falling edge.
        if (i_Switch_1 == 1'b0 && r_Switch_1 == 1'b1)
        begin
            r_LED_1 <= ~r_LED_1;   // Toggle LED output
        end
    end
 
    assign o_LED_1 = r_LED_1;
 
endmodule