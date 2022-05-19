`timescale 1ns / 1ps


module cputop (clk,reset,switch,led);
    input clk;
    input reset;
    // input confirm;
    input[23:0] switch;
    output[23:0] led;
    
    //Ifetch
    wire[31:0] Instruction;
    wire[31:0] branch_base_addr; 
    // ������������ת���ָ����ԣ���ֵΪ(pc+4)����ALU�е�PC_plus_4;
    wire[31:0] Read_data_1;
    wire Branch;
    wire nBranch;
    wire Jmp;
    wire Jal;
    wire Jr;
    wire Zero;
    wire[31:0] link_addr;//JALר��PC+4������decode��opcplus4

   //control32
    wire RegDST;
    wire ALUSrc;
    // wire MemtoReg;
    wire RegWrite;
    wire MemWrite;
    wire I_format;
    wire Sftmd;
    wire[1:0] ALUOp;
    wire MemorIOtoReg;//ԭ����MemtoReg
    wire MemRead;
    wire IORead;
    wire IOWrite;


    //decode32
    wire[31:0] read_data_1;
    wire[31:0] read_data_2;
    wire[31:0] mem_data;
    wire[31:0] ALU_Result;
    wire[31:0] sign_extend;

    //executs32
    wire[31:0] Addr_Result; //ALU�м���õ�����ifetch����ת��ַ

    //dmemory32
    wire[31:0] read_dataFromMemory; 
    //��DATA RAM or I/O portȡ��������,д�Ĵ���������mem_data

    //clock
    wire clock;

    //MemOrIO
    wire LEDCtrl;
    wire SwitchCtrl;
    wire [31:0] read_dataFromMemoryOrIo;
    wire [31:0] write_dataToMemoryOrIo;

    wire rst;

    cpuclock CLK(
        .clkin(clk),
        .clkout(clock)
    );

    Ifetc32 ifetch(
        .Instruction(Instruction),
        .branch_base_addr(branch_base_addr),
        .Addr_result(Addr_Result),
        .Read_data_1(Read_data_1),
        .Branch(Branch),
        .nBranch(nBranch),
        .Jmp(Jmp),
        .Jal(Jal),
        .Jr(Jr),
        .Zero(Zero),
        .clock(clock),
        .reset(rst),
        .link_addr(link_addr)
    );

    control32 controller(
            .Opcode(Instruction[31:26]), 
            .Function_opcode(Instruction[5:0]), 
            .Jr(Jr), 
            .RegDST(RegDST), 
            .ALUSrc(ALUSrc), 
            .MemorIOtoReg(MemorIOtoReg), 
            .RegWrite(RegWrite), 
            .MemWrite(MemWrite), 
            .Branch(Branch), 
            .nBranch(nBranch), 
            .Jmp(Jmp), 
            .Jal(Jal), 
            .I_format(I_format), 
            .Sftmd(Sftmd), 
            .ALUOp(ALUOp),
            .Alu_resultHigh(ALU_Result[31:10]), 
            .MemRead(MemRead), 
            .IORead(IORead), 
            .IOWrite(IOWrite)
    );

    executs32 alu(
        .Read_data_1(read_data_1),
        .Read_data_2(read_data_2),
        .Sign_extend(sign_extend),
        .Function_opcode(Instruction[5:0]),
        .Exe_opcode(Instruction[31:26]),
        .ALUOp(ALUOp),
        .Shamt(Instruction[10:6]),
        .Sftmd(Sftmd),
        .ALUSrc(ALUSrc),
        .I_format(I_format),
        .Jr(Jr),
        .Zero(Zero),
        .ALU_Result(ALU_Result),
        .Addr_Result(Addr_Result),
        .PC_plus_4(branch_base_addr)
    );

    dmemory32 dmemory(
        .clock(clock),
        .memWrite(MemWrite),
        .address(ALU_Result),
        .writeData(read_data_2),
        .readData(read_dataFromMemory)
    );

    decode32 decoder(
        .read_data_1(read_data_1),
        .read_data_2(read_data_2),
        .Instruction(Instruction),
        .mem_data(read_dataFromMemoryOrIo),
        .ALU_result(ALU_Result),
        .Jal(Jal),
        .RegWrite(RegWrite),
        .MemtoReg(MemorIOtoReg),
        .RegDst(RegDST),
        .Sign_extend(sign_extend),
        .clock(clock),
        .reset(rst),
        .opcplus4(link_addr)
    );

    MemOrIO memOrio( 
        .mRead(MemRead), 
        .mWrite(MemWrite), 
        .ioRead(IORead), 
        .ioWrite(IOWrite),
        .addr_in(ALU_Result), 
        .m_rdata(read_dataFromMemory), //��mem������data
        .io_rdata({8'b0000_0000,switch}),//��io������data 
        .r_wdata(read_dataFromMemoryOrIo), //д�ظ�decoder��ֵ 
        .r_rdata(read_data_2), //��decoder�й�����data
        .write_data(write_dataToMemoryOrIo),//д�ظ�io����mem�е�ֵ�����������r_rdata(��Ҫ������ź�ʱ������ź�û��)
        .LEDCtrl(LEDCtrl), //��Ϊ1��ʱ����Ҫ�����led����
        .SwitchCtrl(SwitchCtrl)//��Ϊ1��ʱ����Ҫ�Ӳ��뿪��������
    );

    ioWrite32 ioWrite(
        .writeData(write_dataToMemoryOrIo[23:0]),
        .clock(clock),
        .reset(rst),
        .ioWrite(IOWrite),
        .dataToio(led)
    );

    key_debounce key_rst(
        .sys_clk(clk),
        .key(reset), //�ⲿ����İ���ֵ
        .key_value(rst) //������İ���ֵ
    );

endmodule
