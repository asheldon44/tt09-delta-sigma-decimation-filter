
//`include "./verilog_src/incrementor.v"
//`include "./verilog_src/integrator.v"
//`include "./verilog_src/op_differentiator.v"

`timescale 1ns/1ns

module CIC (
    input wire clk,
    input wire dec_clk,
    input wire rst,
    input wire in,
    output [23:0] out 
);

    wire [23:0] inc_out;
    wire [23:0] int_1_out;
    wire [23:0] int_2_out;
	wire [23:0] extended_in;
	assign extended_in = {23'b00000000000000000000000, in}; 
    generate 
		integrator u_integrator_0(
			.clk(clk),
			.rst(rst),
			.in(extended_in),  // Pass the sign-extended input
			.out(inc_out)
		);
		integrator u_integrator_1(
			.clk(clk),
			.rst(rst),
			.in(inc_out),
			.out(int_1_out)
		);
		integrator u_integrator_2(
			.clk(clk),
			.rst(rst),
			.in(int_1_out),
			.out(int_2_out)
		);
		op_differentiator u_differentiator(
			.clk(clk),
			.rst(rst),
			.lr_clk(dec_clk),
			.in(int_2_out),
			.out(out)
		);
    endgenerate
				
endmodule
