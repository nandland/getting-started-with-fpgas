// Simple testbench to exercise the And_Gate_Project
module And_Gate_TB();
  
  reg r_In1, r_In2;
  wire w_Out;
  
  // Here is where we instantiate the UUT
  And_Gate_Project UUT 
  (.i_Switch_1(r_In1),
   .i_Switch_2(r_In2),
   .o_LED_1(w_Out));
  
  // The steps to exercise the UUT go here
  initial
    begin
      $dumpfile("dump.vcd"); $dumpvars;
      r_In1 <= 1'b0;
      r_In2 <= 1'b0;
      #10;
      assert (w_Out == 1'b0);

      r_In1 <= 1'b0;
      r_In2 <= 1'b1;
      #10;
      assert (w_Out == 1'b0);

      r_In1 <= 1'b1;
      r_In2 <= 1'b0;
      #10;
      assert (w_Out == 1'b0);

      r_In1 <= 1'b1;
      r_In2 <= 1'b1;
      #10;
      assert (w_Out == 1'b1);
      #10;
      $finish();
    end
endmodule