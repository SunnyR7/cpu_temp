`timescale 1ns / 1ps

module cpuclock(
   input clkin,
   output clkout1,
   output clkout2
    );
 cpuclk clk(
   .clk_in1(clkin),
   .clk_out1(clkout1),
   .clk_out2(clkout2)
 );
endmodule
