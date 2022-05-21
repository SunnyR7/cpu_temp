`timescale 1ns / 1ps

module stage_control(clk,reset,uart_stage,rst,start_pg);
input clk;
input reset;
input uart_stage;
output reg rst=1'b0;
output reg start_pg=1'b0;

wire rst_key_value;
wire uart_key_value;
reg start_pg_temp;

key_debounce rst_key(
    .sys_clk(clk),
    .key(reset), 
    .key_value(rst_key_value) 
);
key_debounce uart_key(
    .sys_clk(clk),
    .key(uart_stage), 
    .key_value(uart_key_value) 
);

always @(posedge clk)
begin
    if(uart_key_value)
    begin
    start_pg<=~start_pg_temp;
    end
    else
    begin
    start_pg_temp<=start_pg;
    end
end

always @(posedge clk)
begin
    if(start_pg)
    begin
    rst<=1'b1;
    end
    else if (rst_key_value) 
    begin
        rst<=1'b1;
    end
    else
    begin
        rst<=1'b0;
    end
end

endmodule
