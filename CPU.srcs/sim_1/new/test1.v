
module test1();
reg [23:0] sw=24'h000000;
//output
wire [23:0] led;
reg rst_n,clk,confirm;

cputop test1(
.clk(clk),.rst(rst_n),.confirm(confirm),.switch(sw),.led(led)
);
initial
fork
{sw, rst_n,clk,confirm}={24'h000100,3'b100};
#3 rst_n=1'b0;
#3000 sw=24'h001100;
#4000 sw=24'h000000;
forever #5 clk=~clk;
join

endmodule
