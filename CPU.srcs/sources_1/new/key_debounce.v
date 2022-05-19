`timescale 1ns / 1ps
module key_debounce(
input sys_clk ,
input key , //外部输入的按键值
output reg key_value //消抖后的按键值
);
 
//reg define
reg [19:0] cnt ;
reg key_reg ;

//按键值消抖
always @ (posedge sys_clk) 
begin

    key_reg <= key; //将按键值延迟一拍
    if(key_reg != key) 
        begin //检测到按键状态发生变化
        cnt <= 20'd100_0000; //则将计数器置为 20'd100_0000，
        //即延时 100_0000 * 20ns(1s/50MHz) = 20ms
        end
     else 
        begin //如果当前按键值和前一个按键值一样，即按键没有发生变化
        if(cnt > 20'd0) //则计数器递减到 0
        cnt <= cnt - 1'b1; 
        else
        cnt <= 20'd0;
        end
     
end

//将消抖后的最终的按键值送出去
always @ (posedge sys_clk) begin
if(cnt == 20'd1) begin
key_value <= key;
end
else begin
key_value <= key_value;
end
end 
endmodule
