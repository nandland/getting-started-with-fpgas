module Mux_4_To_1 (input in1, input in2, input in3, input in4, 
                   input sel1, input sel2, output reg out);
 

wire [1:0] sel_concat;
assign sel_concat = {sel1, sel2};

always @(*)
begin
  case (sel_concat)
    2'b00 : out <= in1;
    2'b01 : out <= in2;
    2'b10 : out <= in3;
    2'b11 : out <= in4;
  endcase
end

endmodule
