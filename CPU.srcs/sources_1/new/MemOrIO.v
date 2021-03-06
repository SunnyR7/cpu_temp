`timescale 1ns / 1ps

module MemOrIO( mRead, mWrite, ioRead, ioWrite,addr_in, m_rdata, io_rdata, r_wdata, r_rdata, write_data, LEDCtrl, SwitchCtrl);
input mRead; // read memory, from Controller
input mWrite; // write memory, from Controller
input ioRead; // read IO, from Controller
input ioWrite; // write IO, from Controller

input[31:0] addr_in; // from alu_result in ALU
//output[31:0] addr_out; // address to Data-Memory

input[31:0] m_rdata; // data read from Data-Memory
input[31:0] io_rdata; // data read from IO,32 bits
output[31:0] r_wdata; // data to Decoder(register file)


input[31:0] r_rdata; // data read from Decoder(register file)
output reg[31:0] write_data; // data to memory or I/O??m_wdata, io_wdata??

output  LEDCtrl; // LED Chip Select
output  SwitchCtrl; // Switch Chip Select


//assign addr_out= addr_in;
// The data wirte to register file may be from memory or io. // While the data is from io, it should be the lower 16bit of r_wdata. assign r_wdata = ??????
// Chip select signal of Led and Switch are all active high;
assign LEDCtrl= (ioWrite== 1'b1)?1'b1:1'b0;
assign SwitchCtrl= (ioRead== 1'b1)?1'b1:1'b0;
assign r_wdata=(ioRead==1'b1)?io_rdata:m_rdata;

always @* begin
    if((mWrite==1)||(ioWrite==1))
    //wirte_data could go to either memory or IO. where is it from?
    write_data = r_rdata;
end

endmodule