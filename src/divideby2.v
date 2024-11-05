module divideby2 (
  input  logic clk,
  input  logic rstN,
  output logic clkOut
);

  always_ff @(posedge clk or negedge rstN) begin
    if (!rstN) begin
      clkOut <= 0;
    end
    else begin
      clkOut <= ~clkOut;
    end
  end

endmodule