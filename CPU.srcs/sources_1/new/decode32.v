`timescale 1ns / 1ps

module decode32(read_data_1,read_data_2,Instruction,mem_data,ALU_result,
                 Jal,RegWrite,MemtoReg,RegDst,Sign_extend,clock,reset,opcplus4,hi_from_ALU,lo_from_ALU);
    output[31:0] read_data_1;               // ����ĵ�һ������
    output[31:0] read_data_2;               // ����ĵڶ�������
    input[31:0]  Instruction;               // ȡָ��Ԫ����ָ��
    input[31:0]  mem_data;   				//  ��DATA RAM or I/O portȡ��������
    input[31:0]  ALU_result;   				// ��ִ�е�Ԫ��������Ľ��
    input        Jal;                       //  Ϊ1������Jalָ��, Ϊ0ʱ��ʾ����Jalָ��
    input        RegWrite;                  //  Ϊ1������ָ����Ҫд�Ĵ���        ++
    input        MemtoReg;              // Ϊ1������Ҫ�Ӵ洢����I/O�����ݵ��Ĵ��� ++
    input        RegDst;             //Ϊ1����Ŀ�ļĴ�����rd, ����Ŀ�ļĴ�����rt  ++
    output reg [31:0] Sign_extend;               // ��չ���32λ������
    input		 clock,reset;                // ʱ�Ӻ͸�λ
    input[31:0]  opcplus4;                 // JALָ��ר�õ�PC+4
    input [31:0] hi_from_ALU;
    input [31:0] lo_from_ALU;

    reg[31:0] registers[0:31];//32��32bit�ļĴ���

    reg[31:0] lo;//��32bit����
    reg[31:0] hi;//��32bit������

    wire[2:0] I_format = Instruction[31:29];
    wire[2:0] detail = Instruction[28:26];
    wire[4:0] read_register1 = Instruction[25:21]; //rs
    wire[4:0] read_register2 = Instruction[20:16]; //rt
    wire[4:0] read_register3 = Instruction[15:11]; //rd
    wire hi_lo_calculate = (Instruction[31:26] == 6'b000000 && (Instruction[5:0] == 6'b011001 || Instruction[5:0] == 6'b011011))?1'b1:1'b0;

    wire mflo = (Instruction[31:26] == 6'b000000 && Instruction[5:0] == 6'b010010)? 1'b1: 1'b0;
    wire mfhi = (Instruction[31:26] == 6'b000000 && Instruction[5:0] == 6'b010000)? 1'b1: 1'b0;

    always@(Instruction)begin
        if(I_format == 3'b001) begin
            if(detail == 3'b001 || detail == 3'b011 || detail == 3'b100 || detail == 3'b101 || detail == 3'b110) begin Sign_extend = {16'b0,Instruction[15:0]};  end
            else begin Sign_extend = (Instruction[15] == 1'b1)? {16'b1111_1111_1111_1111,Instruction[15:0]}: {16'b0,Instruction[15:0]}; end
        end
        else Sign_extend =(Instruction[15] == 1'b1)? {16'b1111_1111_1111_1111,Instruction[15:0]}: {16'b0,Instruction[15:0]};
    end
    assign read_data_1 = registers[read_register1];
    assign read_data_2 = registers[read_register2];

    always@(posedge clock) begin 
        if(reset == 1'b1) begin
            registers[0] = 32'b0;
            registers[1] = 32'b0;
            registers[2] = 32'b0;
            registers[3] = 32'b0;
            registers[4] = 32'b0;
            registers[5] = 32'b0;
            registers[6] = 32'b0;
            registers[7] = 32'b0;
            registers[8] = 32'b0;
            registers[9] = 32'b0;
            registers[10] = 32'b0;
            registers[11] = 32'b0;
            registers[12] = 32'b0;
            registers[13] = 32'b0;
            registers[14] = 32'b0;
            registers[15] = 32'b0;
            registers[16] = 32'b0;
            registers[17] = 32'b0;
            registers[18] = 32'b0;
            registers[19] = 32'b0;
            registers[20] = 32'b0;
            registers[21] = 32'b0;
            registers[22] = 32'b0;
            registers[23] = 32'b0;
            registers[24] = 32'b0;
            registers[25] = 32'b0;
            registers[26] = 32'b0;
            registers[27] = 32'b0;
            registers[28] = 32'b0;
            registers[29] = 32'b0;
            registers[30] = 32'b0;
            registers[31] = 32'b0;
            hi = 32'b0;
            lo = 32'b0;
        end
        else  begin
            if(RegWrite) begin  
                if(Jal == 1'b0)begin
                if(RegDst == 1'b1) begin
                    if (read_register3 != 5'b0) begin
                        if(MemtoReg == 1'b1) begin registers[read_register3] <= mem_data;  end
                    else begin  registers[read_register3] <= ALU_result;   end
                    end
                end
                else if(RegDst == 1'b0) begin 
                    if (read_register2 != 5'b0) begin
                        if(MemtoReg == 1'b1) begin registers[read_register2] <= mem_data;  end
                    else begin  registers[read_register2] <= ALU_result;   end
                    end
                end
                end
                else begin
                    registers[31] <= opcplus4;//д��31�żĴ���
                end
            end
            if(hi_lo_calculate)begin
                hi <= hi_from_ALU;
                lo <= lo_from_ALU; 
            end
            if(mflo)begin
                registers[read_register3] <= lo;
            end
            if(mfhi)begin
                registers[read_register3] <= hi;
            end
        end
    end
endmodule
