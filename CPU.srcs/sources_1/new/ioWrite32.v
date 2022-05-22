`timescale 1ns / 1ps

module ioWrite32(writeData,clock,reset,ioWrite,stage_io,dataToio);
input [23:0] writeData;
input clock,reset;
input ioWrite;
output [3:0] stage_io;
output reg[19:0] dataToio;

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
