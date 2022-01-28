// Top of Mux Demonstration
// Instantiates 4 LED blinkers at different frequencies
// User can select which one to output by using S1 and S2
// Demonstrates muxing of any of these to a single LED output (o_LED_1)

module Mux_Project_Top 
   (input i_Clk,
    input i_Switch_1,
    input i_Switch_2,
    output o_LED_1);
    
    Count_And_Toggle #(.COUNT_LIMIT(25000000/2)) Toggle_1Hz 
    (.i_Clk(i_Clk),
     .i_Enable(1'b1),
     .o_Toggle(w_Toggle_1Hz));

    Count_And_Toggle #(.COUNT_LIMIT(25000000/4)) Toggle_2Hz 
    (.i_Clk(i_Clk),
     .i_Enable(1'b1),
     .o_Toggle(w_Toggle_2Hz));

    Count_And_Toggle #(.COUNT_LIMIT(25000000/10)) Toggle_5Hz 
    (.i_Clk(i_Clk),
     .i_Enable(1'b1),
     .o_Toggle(w_Toggle_5Hz));

    Count_And_Toggle #(.COUNT_LIMIT(25000000/20)) Toggle_10Hz 
    (.i_Clk(i_Clk),
     .i_Enable(1'b1),
     .o_Toggle(w_Toggle_10Hz));

    Mux_4_To_1 Mux_4_To_1_Inst 
    (.in1(w_Toggle_1Hz),
     .in2(w_Toggle_2Hz),
     .in3(w_Toggle_5Hz),
     .in4(w_Toggle_10Hz),
     .sel1(i_Switch_1),
     .sel2(i_Switch_2),
     .out(o_LED_1));

endmodule