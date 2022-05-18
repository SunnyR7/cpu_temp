`timescale 1ns / 1ps

module cpuclock(
   input clkin,
   output clkout
    );
 cpuclk clk(
   .clk_in1(clkin),
   .clk_out1(clkout)
 );
endmodule
