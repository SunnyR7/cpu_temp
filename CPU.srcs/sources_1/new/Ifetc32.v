`timescale 1ns / 1ps

module Ifetc32(Instruction,branch_base_addr,Addr_result,Read_data_1,Branch,nBranch,Jmp,Jal,Jr,Zero,clock,reset,link_addr,
                upg_rst_i,upg_clk_i,upg_wen_i,upg_adr_i,upg_dat_i,upg_done_i);
    output[31:0] Instruction;			// 根据PC的值从存放指令的prgrom中取出的指令
    output[31:0] branch_base_addr;      // 对于有条件跳转类的指令而言，该值为(pc+4)送往ALU
    input[31:0]  Addr_result;            // 来自ALU,为ALU计算出的跳转地址
    input[31:0]  Read_data_1;           // 来自Decoder，jr指令用的地址
    input        Branch;                // 来自控制单元 beq
    input        nBranch;               // 来自控制单元 bne
    input        Jmp;                   // 来自控制单元 j
    input        Jal;                   // 来自控制单元 jar
    input        Jr;                   // 来自控制单元  jr
    input        Zero;                  //来自ALU，Zero为1表示两个值相等，反之表示不相等
    input        clock,reset;           //时钟与复位,复位信号用于给PC赋初始值，复位信号高电平有效
    output reg [31:0]link_addr;             // JAL指令专用的PC+4
    input upg_rst_i; // UPG reset (Active High)
    input upg_clk_i; // UPG ram_clk_i (10MHz)
    input upg_wen_i; // UPG write enable
    input [13:0] upg_adr_i; // UPG write address
    input [31:0] upg_dat_i; // UPG write data
    input upg_done_i; // 1 if programming is finished
    
    wire kickOff = upg_rst_i | (~upg_rst_i & upg_done_i);
    reg[31:0] PC,Next_PC;
    prgrom instmem(
    .clka(kickOff ?clock:upg_clk_i),
    .wea (kickOff ? 1'b0: upg_wen_i),
    .addra(kickOff ?PC[15:2]:upg_adr_i),
    .dina (kickOff ? 32'h00000000 : upg_dat_i),
    .douta(Instruction)
    );

    assign branch_base_addr = PC + 4;
    always @* begin
        if((Branch==1'b1 && Zero == 1'b1) ||(nBranch == 1'b1 && Zero == 1'b0))
          Next_PC = Addr_result;
        else if(Jr == 1)
          Next_PC = Read_data_1;
        else begin
             Next_PC = PC + 4;   
        end
    end

    always@(negedge clock) begin
        if(reset == 1'b1)
          PC <= 32'h0000_0000;
        else begin
            if(Jmp == 1'b1) begin
                PC <= {PC[31:28],Instruction[25:0],2'b00};
            end
            else if(Jal == 1'b1) begin
                    link_addr <= Next_PC;
                    PC <= {PC[31:28],Instruction[25:0],2'b00};
            end
            else begin
                PC <= Next_PC; 
            end
        end
    end
endmodule
