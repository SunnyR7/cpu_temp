`timescale 1ns / 1ps

module ioWrite32(writeData,clock,reset,ioWrite,stage_io,dataToio);
input [23:0] writeData;//�ӼĴ�����ͷ����ֵ
input clock,reset;//reset�źŸߵ�ƽ��Ч
input ioWrite;//�ߵ�ƽ��Ч����ʾ����io
output [3:0] stage_io; //������ʾ״̬��ֵ
output reg[19:0] dataToio; //���������ź�

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
