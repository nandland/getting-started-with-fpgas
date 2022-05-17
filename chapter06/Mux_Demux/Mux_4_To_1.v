module Mux_4_To_1 (input i_Data0, 
                   input i_Data1, 
                   input i_Data2, 
                   input i_Data3,
                   input i_Sel1, 
                   input i_Sel0, 
                   output o_Data);
 
assign o_Data = !i_Sel1 & !i_Sel0 ? i_Data0 :
                !i_Sel1 &  i_Sel0 ? i_Data1 :
                 i_Sel1 & !i_Sel0 ? i_Data2 : i_Data3;
  
endmodule
