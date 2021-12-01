module And_Gate_Project(
    // Push-Button Switches:
    input i_Switch_1,  
    input i_Switch_2,
    // LED Output
    output o_LED_1);
       
// LUT gets created here
assign o_LED_1 = i_Switch_1 & i_Switch_2;
 
endmodule 
