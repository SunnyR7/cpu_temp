`timescale 1ns / 1ps

module ioWrite32(writeData,clock,reset,ioWrite,dataToio);
input [23:0] writeData;
input clock,reset;
input ioWrite;
output reg[23:0] dataToio;

always@(posedge clock) begin 
        if(reset == 1'b1) begin
            dataToio<=24'b0000_0000_0000_0000_0000_0000;
        end
        else  begin
            if(ioWrite) begin  
                dataToio<=writeData;
            end
        end
    end

endmodule
