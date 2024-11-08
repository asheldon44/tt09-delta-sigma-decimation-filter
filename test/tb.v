`default_nettype none
`timescale 1ns / 1ns

/* This testbench just instantiates the module and makes some convenient wires
   that can be driven / tested by the cocotb test.py.
*/

integer fd;

module tb ();

  // Dump the signals to a VCD file. You can view it with gtkwave.
  initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0, tb);
    fd = $fopen("outdata.txt", "w");
    #1;
  end

  // Wire up the inputs and outputs:
  reg clk;
  reg rst_n;
  reg ena;
  reg [7:0] ui_in;
  reg [7:0] uio_in;
  wire [7:0] uo_out;
  wire [7:0] uio_out;
  wire [7:0] uio_oe;
`ifdef GL_TEST
  wire VPWR = 1'b1;
  wire VGND = 1'b0;
`endif
  reg [23:0] out_code;
  reg out_valid;

  always @(posedge uio_out[2]) begin
    out_valid <= 0;
    #320;
    out_code[23:16] <= uo_out[7:0];
    #160;
    out_code[15:8] <= uo_out[7:0];
    #160;
    out_code[7:0] <= uo_out[7:0];
    #1;
    out_valid <=1;
    $fwrite(fd, "%d,%d\n", $time, out_code);
  end

  // Replace tt_um_example with your module name:
  tt_um_asheldon44_dsm_decimation_filter user_project (

      // Include power ports for the Gate Level test:
`ifdef GL_TEST
      .VPWR(VPWR),
      .VGND(VGND),
`endif

      .ui_in  (ui_in),    // Dedicated inputs
      .uo_out (uo_out),   // Dedicated outputs
      .uio_in (uio_in),   // IOs: Input path
      .uio_out(uio_out),  // IOs: Output path
      .uio_oe (uio_oe),   // IOs: Enable path (active high: 0=input, 1=output)
      .ena    (ena),      // enable - goes high when design is selected
      .clk    (clk),      // clock
      .rst_n  (rst_n)     // not reset
  );

endmodule
