`timescale 1ns / 1ps

module ioWrite32(writeData,clock,reset,ioWrite,stage_io,dataToio);
input [23:0] writeData;
input clock,reset;
input ioWrite;
output [2:0] stage_io;
output reg[23:0] dataToio;

assign stage_io=writeData[23:21];

always@(posedge clock) begin 
        if(reset == 1'b1) begin
            dataToio<=21'b0_0000_0000_0000_0000_0000;
        end
        else  begin
            if(ioWrite) begin  
                dataToio<=writeData[20:0];
            end
        end
    end

endmodule
