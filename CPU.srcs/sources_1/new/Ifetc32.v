`timescale 1ns / 1ps

module Ifetc32(Instruction,branch_base_addr,Addr_result,Read_data_1,Branch,nBranch,Jmp,Jal,Jr,Zero,clock,reset,link_addr);
    output[31:0] Instruction;			// ����PC��ֵ�Ӵ��ָ���prgrom��ȡ����ָ��
    output[31:0] branch_base_addr;      // ������������ת���ָ����ԣ���ֵΪ(pc+4)����ALU
    input[31:0]  Addr_result;            // ����ALU,ΪALU���������ת��ַ
    input[31:0]  Read_data_1;           // ����Decoder��jrָ���õĵ�ַ
    input        Branch;                // ���Կ��Ƶ�Ԫ beq
    input        nBranch;               // ���Կ��Ƶ�Ԫ bne
    input        Jmp;                   // ���Կ��Ƶ�Ԫ j
    input        Jal;                   // ���Կ��Ƶ�Ԫ jar
    input        Jr;                   // ���Կ��Ƶ�Ԫ  jr
    input        Zero;                  //����ALU��ZeroΪ1��ʾ����ֵ��ȣ���֮��ʾ�����
    input        clock,reset;           //ʱ���븴λ,��λ�ź����ڸ�PC����ʼֵ����λ�źŸߵ�ƽ��Ч
    output reg [31:0]link_addr;             // JALָ��ר�õ�PC+4
    
    reg[31:0] PC,Next_PC;
    prgrom instmem(
    .clka(clock),
    .addra(PC[15:2]),
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
