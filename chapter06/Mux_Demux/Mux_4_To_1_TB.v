module Mux_4_To_1_TB ();
 
reg r_Data0 = 1'b1, r_Data1 = 1'b0, r_Data2 = 1'b0, r_Data3 = 1'b0;
reg r_Sel1 = 1'b0, r_Sel0 = 1'b0;
wire w_Out;

Mux_4_To_1 UUT (.i_Data0(r_Data0), 
                .i_Data1(r_Data1), 
                .i_Data2(r_Data2), 
                .i_Data3(r_Data3),
                .i_Sel0(r_Sel0), 
                .i_Sel1(r_Sel1), 
                .o_Data(w_Out));

// Takes input integer and drives select inputs
task set_select(input reg [1:0] sel);
  #1;
  r_Sel1 = sel[1];
  r_Sel0 = sel[0];
  #1;
endtask


initial 
begin
  set_select(0);
  assert (w_Out == r_Data0);
  set_select(1);
  assert (w_Out == r_Data1);
  set_select(2);
  assert (w_Out == r_Data2);
  set_select(3);
  assert (w_Out == r_Data3);
  $finish();
end

endmodule
