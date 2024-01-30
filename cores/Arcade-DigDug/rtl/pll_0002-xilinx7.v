`timescale 1ns/10ps
module  pll_0002(
	input wire refclk,
	input wire rst,
	output wire outclk_0,
	output wire outclk_1,
	output wire locked
);

	wire feedback;

	wire outclk_0_bufg;
	wire outclk_1_bufg;
	
	PLLE2_ADV #(
		.CLKFBOUT_MULT(6'd26),
		.CLKIN1_PERIOD(20.0),
		.CLKOUT0_DIVIDE(7'd27), // 48.648 MHz ~= 50 MHz * 26 / 27
		.CLKOUT0_PHASE(1'd0),
		.CLKOUT1_DIVIDE(7'd54), // 24.324 MHz ~= 50 MHz * 26 / 54
		.CLKOUT1_PHASE(1'd0),
		.DIVCLK_DIVIDE(1'd1),
		.REF_JITTER1(0.01),
		.STARTUP_WAIT("FALSE")
	) PLLE2_ADV (
		.CLKFBIN(feedback),
		.CLKIN1(refclk),
		.PWRDWN(1'b0),
		.RST(rst),
		.CLKFBOUT(feedback),
		.CLKOUT0(outclk_0_bufg),
		.CLKOUT1(outclk_1_bufg),
		.LOCKED(locked)
	);

	BUFG outclk_bufg_0 (.I(outclk_0_bufg), .O(outclk_0));
	BUFG outclk_bufg_1 (.I(outclk_1_bufg), .O(outclk_1));	
endmodule