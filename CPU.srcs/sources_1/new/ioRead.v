`timescale 1ns / 1ps

module ioRead(
    input clk,
    output  [15:0]out_value_right,
    output  [2:0]out_value_left,
    input [23:0]sw,
    input key_backspace,
    input[3:0] row, output  [3:0] col_n,
    output [7:0] tube_char, output [7:0] tube_switch
);

wire backspace_key_value1;
key_debounce key1(clk,key_backspace,backspace_key_value1);

reg[31:0] num=32'b10111111_10111111_10111111_10111111;

tubeDriver tube(clk,~sw[20],8'b1111_1111,8'b1111_1111,8'b1111_1111,8'b1111_1111,~num[31:24],~num[23:16],~num[15:8],~num[7:0],tube_switch,tube_char);
wire key_pressed_flag;
wire [7:0] key_seg;
keyboard key (clk,~sw[20],row,col_n,key_pressed_flag,key_seg);

reg[31:0] d;

always @(posedge clk)
begin
    if(sw[20])
    begin
    num<=32'b10111111_10111111_10111111_10111111;
    end
    else if (backspace_key_value1) 
    begin
        num<={8'b10111111,d[31:8]};
    end
    else if(key_pressed_flag)
    begin
        num<={d[23:0],~key_seg};
    end
    else
    begin
    d<=num;
    end
end

reg [15:0] value_from_tube=16'b0000_0000_0000_0000;
reg [15:0] value_temp=16'b0000_0000_0000_0000;

assign out_value_right=(sw[20]==1'b1)?sw[15:0]:value_from_tube;
assign out_value_left=(sw[20]==1'b1)?sw[23:21]:value_from_tube[2:0];

reg [3:0] value_decoder;

always@(*)
    begin
        case (key_seg)
            8'b01000000:value_decoder=4'b0000;
            8'b01111001:value_decoder=4'b0001;
            8'b00100100:value_decoder=4'b0010;
            8'b00110000:value_decoder=4'b0011;
             
            8'b00011001:value_decoder=4'b0100;
            8'b00010010:value_decoder=4'b0101;
            8'b00000010:value_decoder=4'b0110;
            8'b01111000:value_decoder=4'b0111;
            
            8'b00000000:value_decoder=4'b1000;
            8'b00010000:value_decoder=4'b1001;
            8'b00001000:value_decoder=4'b1010;
            8'b00000011:value_decoder=4'b1011;

            8'b01000110:value_decoder=4'b1100;
            8'b00010001:value_decoder=4'b1101;
            8'b00000110:value_decoder=4'b1110;
            8'b00001110:value_decoder=4'b1111;
          endcase
    end

always @(posedge clk)
begin
    if(sw[20])
    begin
        value_from_tube<=16'b0000_0000_0000_0000;
    end
    else if (backspace_key_value1) 
    begin
        value_from_tube<={4'b0000,value_temp[15:4]};
    end
    else if(key_pressed_flag)
    begin
        value_from_tube<={value_temp[11:0],value_decoder};
    end
    else
    begin
        value_temp<=value_from_tube;
    end
end

endmodule
