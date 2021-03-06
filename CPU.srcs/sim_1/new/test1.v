
module test1();
reg [23:0] sw=24'h000000;
//output
wire [23:0] led;
reg clk;

cputop test1(
.clk(clk),.switch(sw),.led(led)
);
initial
fork
{sw,clk}={24'b0000_0010_0000_0000_0000_0000,1'b0};
#10 sw=24'b0010_0000_0000_0000_0000_0000;
#3000 sw=24'b0010_0000_0000_0000_0000_0000;
#3010 sw=24'b0011_0000_0000_0000_0000_0000;
#4000 sw=24'b000_000_00_0000_1000_0000_0000;
#4010 sw=24'b000_010_00_0000_1000_0000_0000;
forever #5 clk=~clk;
join

endmodule
