`timescale 1ns / 1ps

module ioWrite32(writeData,clock,reset,ioWrite,stage_io,dataToio);
input [23:0] writeData;//从寄存器里头来的值
input clock,reset;//reset信号高电平有效
input ioWrite;//高电平有效，表示读入io
output [3:0] stage_io; //三个表示状态的值
output reg[19:0] dataToio; //表达输出的信号

assign stage_io=writeData[23:20];

always@(posedge clock) begin 
        if(reset == 1'b1) begin
            dataToio<=19'b000_0000_0000_0000_0000;
        end
        else  begin
            if(ioWrite) begin  
                dataToio<=writeData[19:0];
            end
        end
    end

endmodule
