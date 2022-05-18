`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/18 17:28:24
// Design Name: 
// Module Name: cpuclock
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module cpuclock(
   input clkin,
   output clkout
    );
 cpuclk clk(
   .clk_in1(clkin),
   .clk_out1(clkout)
 );
endmodule
