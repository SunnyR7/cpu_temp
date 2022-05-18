`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/18 17:11:55
// Design Name: 
// Module Name: dmemory32
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


module dmemory32(readData,address,writeData,memWrite,clock);
input clock;
input memWrite;
input [31:0] address;
input[31:0] writeData;
output[31:0] readData;
wire clk;
RAM ram(
.clka(clk),
.wea(memWrite),
.addra(address[15:2]),
.dina(writeData),
.douta(readData)
);

assign clk = !clock;
endmodule
