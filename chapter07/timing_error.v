module timing_error
  (input  i_Clk,
   input [7:0] i_Data,
   output reg [7:0] o_Data);

  reg [7:0] r0_Data = 0;
  reg [7:0] r1_Data = 0;
  reg [7:0] r2_Data = 0;

  always @(posedge i_Clk)
  begin
    // Register so tools know r0_Data
    // is in i_Clk clock domain.
    r0_Data <= i_Data;

    // BAD: Long propagation delay
    o_Data <= ((r0_Data / 3) + 1) * 5;

    // FIX: Pipeline math operations
    //r1_Data <= r0_Data / 3;
    //r2_Data <= r1_Data + 1;
    //o_Data  <= r2_Data * 5;

  end

endmodule // timing_error

