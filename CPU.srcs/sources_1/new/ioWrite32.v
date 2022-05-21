`timescale 1ns / 1ps

module ioWrite32(writeData,clock,reset,ioWrite,stage_io,dataToio);
input [23:0] writeData;
input clock,reset;
input ioWrite;
output [1:0] stage_io;
output reg[23:0] dataToio;

assign stage_io=writeData[23:22];

always@(posedge clock) begin 
        if(reset == 1'b1) begin
            dataToio<=22'b00_0000_0000_0000_0000_0000;
        end
        else  begin
            if(ioWrite) begin  
                dataToio<=writeData[21:0];
            end
        end
    end

endmodule
