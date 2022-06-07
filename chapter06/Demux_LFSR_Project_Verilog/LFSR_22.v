module LFSR_22 (
  input         i_Clk,
  output [21:0] o_LFSR_Data,
  output        o_LFSR_Done);

reg [21:0] r_LFSR;
wire       w_XNOR;

always @(posedge i_Clk)
begin
  r_LFSR <= {r_LFSR[20:0], w_XNOR};
end

assign w_XNOR = r_LFSR[21] ^~ r_LFSR[20];
assign o_LFSR_Done = (r_LFSR == 22'd0);
assign o_LFSR_Data = r_LFSR;

endmodule
