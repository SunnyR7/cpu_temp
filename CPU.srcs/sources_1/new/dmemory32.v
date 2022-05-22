`timescale 1ns / 1ps

module dmemory32(readData,address,writeData,memWrite,clock,upg_rst_i,upg_clk_i,upg_wen_i,upg_adr_i,upg_dat_i,upg_done_i);
input clock;
input memWrite;//是否进行写寄存器的操作（active high）
input [31:0] address;//来自ALU的计算地址ALU_result
input[31:0] writeData;//decoder读出的read_data_2
output[31:0] readData;//dmem读出的数据
input upg_rst_i; // UPG reset (Active High)
input upg_clk_i; // UPG ram_clk_i (10MHz)
input upg_wen_i; // UPG write enable
input [13:0] upg_adr_i; // UPG write address
input [31:0] upg_dat_i; // UPG write data
input upg_done_i; // 1 if programming is finished

wire clk;
assign clk = !clock;
wire kickOff = upg_rst_i | (~upg_rst_i & upg_done_i);

RAM ram (
.clka (kickOff ? clk : upg_clk_i),
.wea (kickOff ? memWrite : upg_wen_i),
.addra (kickOff ? address[15:2] : upg_adr_i),
.dina (kickOff ? writeData : upg_dat_i),
.douta (readData)
);


endmodule
