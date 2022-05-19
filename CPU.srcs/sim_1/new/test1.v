
module test1();
reg [23:0] sw=24'h000000;
//output
wire [23:0] led;
reg rst_n,clk;

cputop test1(
.clk(clk),.reset(rst_n),.switch(sw),.led(led)
);
initial
fork
{sw, rst_n,clk}={24'h000100,2'b10};
#3 rst_n=1'b0;
#3000 sw=24'b0010_0000_0000_0000_0000_0000;
#3010 sw=24'b0011_0000_0000_0000_0000_0000;
#4000 sw=24'b000_000_00_0000_1000_0000_0000;
#4010 sw=24'b000_010_00_0000_1000_0000_0000;
forever #5 clk=~clk;
join

endmodule
