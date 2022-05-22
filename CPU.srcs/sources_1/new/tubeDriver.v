module tubeDriver ( 
    input clk, reset,
    input[7:0] text7,//第7个七段数码管的值
    input[7:0] text6,//第6个七段数码管的值
    input[7:0] text5,//第5个七段数码管的值
    input[7:0] text4,//第4个七段数码管的值
    input[7:0] text3,//第3个七段数码管的值
    input[7:0] text2,//第2个七段数码管的值
    input[7:0] text1,//第1个七段数码管的值
    input[7:0] text0,//第0个七段数码管的值
    output[7:0] seg_en,
    output[7:0] seg_out
);
    wire clkout;
    reg[31:0] cnt;
    reg[2:0] scan_cnt;
    reg[7:0] seg_out_reg;
    reg[7:0] seg_en_reg;
    assign seg_en = ~seg_en_reg;
    assign seg_out = seg_out_reg;

    // divide frequency
    frequency #(200000) clock_f1(clk, reset,clkout);

    //scan
    always @(posedge clkout or negedge reset)//change scan_cnt based on clkout
    begin
        if(!reset)
            scan_cnt <= 0;
        else begin
            scan_cnt <= scan_cnt +1;
            if(scan_cnt==3'd7) scan_cnt<=0;
        end
    end

    wire[7:0] text71;
    wire[7:0] text61;
    wire[7:0] text51;
    wire[7:0] text41;
    wire[7:0] text31;
    wire[7:0] text21;
    wire[7:0] text11;
    wire[7:0] text01;

    assign text71=(reset==1'b1)?text7:8'b1111_1111;
    assign text61=(reset==1'b1)?text6:8'b1111_1111;
    assign text51=(reset==1'b1)?text5:8'b1111_1111;
    assign text41=(reset==1'b1)?text4:8'b1111_1111;
    assign text31=(reset==1'b1)?text3:8'b1111_1111;
    assign text21=(reset==1'b1)?text2:8'b1111_1111;
    assign text11=(reset==1'b1)?text1:8'b1111_1111;
    assign text01=(reset==1'b1)?text0:8'b1111_1111;

    always @(scan_cnt)//select tube
    begin
        case(scan_cnt)
            3'b000:seg_en_reg=8'b0000_0001;
            3'b001:seg_en_reg=8'b0000_0010;
            3'b010:seg_en_reg=8'b0000_0100;
            3'b011:seg_en_reg=8'b0000_1000;
            3'b100:seg_en_reg=8'b0001_0000;
            3'b101:seg_en_reg=8'b0010_0000;
            3'b110:seg_en_reg=8'b0100_0000;
            3'b111:seg_en_reg=8'b1000_0000;
            default: seg_en_reg = 0;
        endcase
    end


    always @(scan_cnt) begin
        case (scan_cnt)
            7: seg_out_reg = text71;
            6: seg_out_reg = text61;
            5: seg_out_reg = text51;
            4: seg_out_reg = text41;
            3: seg_out_reg = text31;
            2: seg_out_reg = text21;
            1: seg_out_reg = text11;
            0: seg_out_reg = text01;
            default: seg_out_reg=8'b1111_1111;
        endcase
    end
endmodule