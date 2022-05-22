`timescale 1ns / 1ps

module control32(Opcode, Function_opcode, Jr, RegDST, ALUSrc, MemorIOtoReg, RegWrite, MemWrite, Branch, nBranch, Jmp, Jal, I_format, Sftmd, ALUOp,Alu_resultHigh, MemRead, IORead, IOWrite);
    input[5:0]   Opcode;            // ����IFetchģ���ָ���6bit, instruction[31..26]
    input[5:0]   Function_opcode;  	// ����IFetchģ���ָ���6bit, ��������r-�����е�ָ��, instructions[5..0]
    input[21:0]  Alu_resultHigh;   //��alu����ĵ�ַ���룬��ַ�ĸ�22bitλ
    output       Jr;         	 // Ϊ1������ǰָ����jr, Ϊ0��ʾ��ǰָ���jr
    output       RegDST;          // Ϊ1����Ŀ�ļĴ�����rd, ����Ŀ�ļĴ�����rt
    output       ALUSrc;          // Ϊ1�����ڶ�����������ALU�е�Binput������������beq, bne���⣩, Ϊ0ʱ��ʾ�ڶ������������ԼĴ���
    output       MemorIOtoReg;     // Ϊ1������Ҫ�Ӵ洢����I/O�����ݵ��Ĵ��� lw
    output       RegWrite;   	  // Ϊ1������ָ����Ҫд�Ĵ���
    output       MemWrite;       // Ϊ1������ָ����Ҫд�洢��
    output       Branch;        // Ϊ1������beqָ��, Ϊ0ʱ��ʾ����beqָ��
    output       nBranch;       // Ϊ1������Bneָ��, Ϊ0ʱ��ʾ����bneָ��
    output       Jmp;            // Ϊ1������Jָ��, Ϊ0ʱ��ʾ����Jָ��
    output       Jal;            // Ϊ1������Jalָ��, Ϊ0ʱ��ʾ����Jalָ��
    output       I_format;      // Ϊ1������ָ���ǳ�beq, bne, LW, SW֮�������I-����ָ��
    output       Sftmd;         // Ϊ1��������λָ��, Ϊ0����������λָ��
    output[1:0]  ALUOp;        // ��R-���ͻ�I_format=1ʱλ1����bitλ��Ϊ1,  beq��bneָ����λ0����bitλ��Ϊ1
    output MemRead;//Ϊ1����Ҫ��mem���� active high
    output IORead;//Ϊ1����Ҫ��io���� active high
    output IOWrite;//Ϊ1����Ҫд��io active high


wire R_format = (Opcode == 6'b000000)? 1'b1: 1'b0;
assign Jr = ((Opcode == 6'b000000) && (Function_opcode == 6'b001000)) ? 1'b1 :1'b0;
assign RegDST = R_format;
assign ALUSrc = (Opcode[5:3] == 3'b001|| Opcode == 6'b100011 ||Opcode == 6'b101011)?1'b1 :1'b0;
assign MemWrite = (Opcode == 6'b101011&& Alu_resultHigh!= 22'b1111_1111_1111_1111_1111_11)? 1'b1 :1'b0;
assign Branch = (Opcode == 6'b000100)? 1'b1: 1'b0;
assign nBranch = (Opcode == 6'b000101)? 1'b1: 1'b0;
assign Jmp = (Opcode == 6'b000010)? 1'b1: 1'b0;
assign Jal = (Opcode == 6'b000011)? 1'b1: 1'b0;
assign I_format = (Opcode[5:3] == 3'b001)? 1'b1: 1'b0;
assign RegWrite = ((R_format || Opcode == 6'b100011 || Opcode == 6'b000011 ||I_format) &&(!Jr))? 1'b1: 1'b0;
assign Sftmd = (((Function_opcode==6'b000000)||(Function_opcode==6'b000010)||(Function_opcode==6'b000011)||(Function_opcode==6'b000100)||(Function_opcode==6'b000110)||(Function_opcode==6'b000111))&& R_format)? 1'b1:1'b0;
assign ALUOp = {(R_format|| I_format),(Branch||nBranch)};
assign MemRead = (Opcode == 6'b100011 && Alu_resultHigh!= 22'b1111_1111_1111_1111_1111_11)? 1'b1 :1'b0; // Read memory //Alu_resultHigh
assign IORead = (Opcode == 6'b100011 && Alu_resultHigh== 22'b1111_1111_1111_1111_1111_11)? 1'b1 :1'b0;
assign IOWrite =(Opcode == 6'b101011 && Alu_resultHigh== 22'b1111_1111_1111_1111_1111_11)? 1'b1 :1'b0; // Write output //
assign MemorIOtoReg = (Opcode == 6'b100011)? 1'b1 :1'b0;

endmodule