module divideby64 (
  input  logic clk,
  input  logic rstN,
  output logic clkOut
);

  logic clkOutDiv1;
  logic clkOutDiv2;
  logic clkOutDiv3;
  logic clkOutDiv4;
  logic clkOutDiv5;

  divideby2 divideBy2_1 (
    .clk(clk),
    .rstN(rstN),
    .clkOut(clkOutDiv1)
  );

  divideby2 divideBy2_2 (
    .clk(clkOutDiv1),
    .rstN(rstN),
    .clkOut(clkOutDiv2)
  );

  divideby2 divideBy2_3 (
    .clk(clkOutDiv2),
    .rstN(rstN),
    .clkOut(clkOutDiv3)
  );

  divideby2 divideBy2_4 (
    .clk(clkOutDiv3),
    .rstN(rstN),
    .clkOut(clkOutDiv4)
  );

  divideby2 divideBy2_5 (
    .clk(clkOutDiv4),
    .rstN(rstN),
    .clkOut(clkOutDiv5)
  );

  divideby2 divideBy2_6 (
    .clk(clkOutDiv5),
    .rstN(rstN),
    .clkOut(clkOut)
  );

endmodule