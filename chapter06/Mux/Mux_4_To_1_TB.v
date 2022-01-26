module Mux_4_To_1_TB ();
 
reg r_In1 = 1'b1, r_In2 = 1'b0, r_In3 = 1'b0, r_In4 = 1'b0;
reg r_Sel1 = 1'b0, r_Sel2 = 1'b0;
wire w_Out;

Mux_4_To_1 UUT (.in1(r_In1), .in2(r_In2), .in3(r_In3), .in4(r_In4),
                .sel1(r_Sel1), .sel2(r_Sel2), .out(w_Out));

initial 
begin
    #1;

end

endmodule
