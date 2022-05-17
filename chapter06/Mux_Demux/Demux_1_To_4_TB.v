// Simple testbench to verify Demux functionality

module Demux_1_To_4_TB ();
 
wire w_Data0, w_Data1, w_Data2, w_Data3;
reg r_Sel1 = 1'b0, r_Sel0 = 1'b0;
reg r_Data = 1'b1;

Demux_1_To_4 UUT (.i_Data(r_Data),
                  .i_Sel1(r_Sel1), 
                  .i_Sel0(r_Sel0), 
                  .o_Data0(w_Data0), 
                  .o_Data1(w_Data1), 
                  .o_Data2(w_Data2), 
                  .o_Data3(w_Data3));                

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
  assert (w_Data0);
  assert (!w_Data1);
  assert (!w_Data2);
  assert (!w_Data3);

  set_select(1);
  assert (!w_Data0);
  assert (w_Data1);
  assert (!w_Data2);
  assert (!w_Data3);
  
  set_select(2);
  assert (!w_Data0);
  assert (!w_Data1);
  assert (w_Data2);
  assert (!w_Data3);
  
  set_select(3);
  assert (!w_Data0);
  assert (!w_Data1);
  assert (!w_Data2);
  assert (w_Data3);
  
  $finish();
end

endmodule
