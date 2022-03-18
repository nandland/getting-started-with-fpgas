module Mux_4_To_1 (input in1, input in2, input in3, input in4, 
                   input sel1, input sel2, output out);
 
assign out = !sel1 & !sel2 ? in1 :
             !sel1 &  sel2 ? in2 :
              sel1 & !sel2 ? in3 : in4;
  
endmodule
