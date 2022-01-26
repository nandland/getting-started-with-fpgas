module Mux_4_To_1 (input in1, input in2, input in3, input in4, 
                   input sel1, input sel2, output out);
 
assign out = sel1 ? (sel2 ? in4 : in3) :
                    (sel2 ? in2 : in1);

endmodule
