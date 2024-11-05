/*
 * Copyright (c) 2024 Your Alexander Sheldon
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_asheldon44_dsm_decimation_filter (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, 1'b0};

  wire dec_in;

  // ADC 1 bit inpput
  assign dec_in = ui_in[0];

  // Output of the decimation filter (Z in decimation_filter module)
  wire [23:0] dec_out; 

  // Enable the all uio pins for output
  assign uio_oe = 8'b11111111;
    
  // Assign most significant 8 bits to the dedicated output pins
  assign uo_out = dec_out[15:8];

  // Assign less significant 8 bits to the general-purpose IO pins
  assign uio_out = dec_out[7:0];


  clk_divider divideby64(.clk(clk),
                         .rstN(rst_n),
                         .clkOut(div_clk)
                        );

  decimation_filter CIC(.clk(clk),
                        .dec_clk(div_clk),
                        .rst(~rst_n),
                        .in(dec_in),
                        .out(dec_out)
                      );

endmodule
