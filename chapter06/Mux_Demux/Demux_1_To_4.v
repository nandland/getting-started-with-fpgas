// Implements a 1-4 Demultiplexer.
// In reality, it is unlikely you would put a demux in a dedicated module.

module Demux_1_To_4 (input  i_Data,
                     input  i_Sel1, 
                     input  i_Sel0, 
                     output o_Data0,
                     output o_Data1,
                     output o_Data2,
                     output o_Data3);
 
assign o_Data0 = !i_Sel1 & !i_Sel0 ? i_Data : 1'b0;
assign o_Data1 = !i_Sel1 &  i_Sel0 ? i_Data : 1'b0;
assign o_Data2 =  i_Sel1 & !i_Sel0 ? i_Data : 1'b0;
assign o_Data3 =  i_Sel1 &  i_Sel0 ? i_Data : 1'b0;
  
endmodule
