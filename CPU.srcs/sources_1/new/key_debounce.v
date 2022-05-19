`timescale 1ns / 1ps
module key_debounce(
input sys_clk ,
input key , //�ⲿ����İ���ֵ
output reg key_value //������İ���ֵ
);
 
//reg define
reg [19:0] cnt ;
reg key_reg ;

//����ֵ����
always @ (posedge sys_clk) 
begin

    key_reg <= key; //������ֵ�ӳ�һ��
    if(key_reg != key) 
        begin //��⵽����״̬�����仯
        cnt <= 20'd100_0000; //�򽫼�������Ϊ 20'd100_0000��
        //����ʱ 100_0000 * 20ns(1s/50MHz) = 20ms
        end
     else 
        begin //�����ǰ����ֵ��ǰһ������ֵһ����������û�з����仯
        if(cnt > 20'd0) //��������ݼ��� 0
        cnt <= cnt - 1'b1; 
        else
        cnt <= 20'd0;
        end
     
end

//������������յİ���ֵ�ͳ�ȥ
always @ (posedge sys_clk) begin
if(cnt == 20'd1) begin
key_value <= key;
end
else begin
key_value <= key_value;
end
end 
endmodule
