`timescale 1ns / 1ps


module cputop (clk,switch,led,rx,tx);
    input clk;
    // input confirm;
    input[23:0] switch;
    output[23:0] led;
    input rx;
    output tx;
    //input是uart接口传入，这个每次传1bit
    //output是cpu告诉另一边接收结束了

    //reset信号是拨码开关从左往右数第7个
    //开始uart通信时拨码开关从左往右数第8个
    //上面这两个表示状态的信号可以变成按键，暂时是弄的拨码开关
    //就可以弄成按一下是reset，再按一下是正常状态，可以是reset不变，外面弄一个按一下reset取反一次的

    //使用了两个拨码开关表示状态
    //从左往右数第7个 和 从左往右数第8个
    //从左往右数第8个拨上去的时候 是uart通信模式，同时进行rst
    //当从两个开关任意一个拨上去的都是rst状态
    //只有当两个开关都拨下来才是正常工作状态
    wire rst;
    assign rst=switch[17]|switch[16];
    wire start_pg;
    assign start_pg=switch[16];
    
    //Ifetch
    wire[31:0] Instruction;
    wire[31:0] branch_base_addr; 
    // 对于有条件跳转类的指令而言，该值为(pc+4)送往ALU中的PC_plus_4;
    wire[31:0] Read_data_1;
    wire Branch;
    wire nBranch;
    wire Jmp;
    wire Jal;
    wire Jr;
    wire Zero;
    wire[31:0] link_addr;//JAL专用PC+4，传给decode中opcplus4

   //control32
    wire RegDST;
    wire ALUSrc;
    // wire MemtoReg;
    wire RegWrite;
    wire MemWrite;
    wire I_format;
    wire Sftmd;
    wire[1:0] ALUOp;
    wire MemorIOtoReg;//原来的MemtoReg
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
    wire[31:0] Addr_Result; //ALU中计算得到，给ifetch的跳转地址

    //dmemory32
    wire[31:0] read_dataFromMemory; 
    //从DATA RAM or I/O port取出的数据,写寄存器的数据mem_data

    //clock
    wire clock;
    wire clock_uart;

    //MemOrIO
    wire LEDCtrl;
    wire SwitchCtrl;
    wire [31:0] read_dataFromMemoryOrIo;
    wire [31:0] write_dataToMemoryOrIo;


    //uart
    // UART Programmer Pinouts
    wire upg_clk_o;
    wire upg_wen_o; //Uart write out enable
    wire upg_done_o; //Uart rx data have done
    //data to which memory unit of program_rom/dmemory32
    wire [14:0] upg_adr_o;
    //data to program_rom or dmemory32
    wire [31:0] upg_dat_o;

    uart uart(
        .upg_clk_i(clock_uart),
        .upg_rst_i(~start_pg),
        .upg_rx_i(rx),
        .upg_clk_o(upg_clk_o),
        .upg_wen_o(upg_wen_o),
        .upg_adr_o(upg_adr_o),
        .upg_dat_o(upg_dat_o),
        .upg_done_o(upg_done_o),
        .upg_tx_o(tx)
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
        .link_addr(link_addr),
        .upg_rst_i(~start_pg),
        .upg_clk_i(upg_clk_o),
        .upg_wen_i(upg_wen_o& (!upg_adr_o[14])),
        .upg_adr_i(upg_adr_o[13:0]),
        .upg_dat_i(upg_dat_o),
        .upg_done_i(upg_done_o)
    );

    dmemory32 dmemory(
        .clock(clock),
        .memWrite(MemWrite),
        .address(ALU_Result),
        .writeData(read_data_2),
        .readData(read_dataFromMemory),
        .upg_rst_i(~start_pg),
        .upg_clk_i(upg_clk_o),
        .upg_wen_i(upg_wen_o& upg_adr_o[14]),
        .upg_adr_i(upg_adr_o[13:0]),
        .upg_dat_i(upg_dat_o),
        .upg_done_i(upg_done_o)
    );

    cpuclock CLK(
        .clkin(clk),
        .clkout1(clock),
        .clkout2(clock_uart)
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
        .m_rdata(read_dataFromMemory), //从mem过来的data
        .io_rdata({8'b0000_0000,switch}),//从io过来的data 
        .r_wdata(read_dataFromMemoryOrIo), //写回给decoder的值 
        .r_rdata(read_data_2), //从decoder中过来的data
        .write_data(write_dataToMemoryOrIo),//写回给io或者mem中的值，就是上面的r_rdata(需要用这个信号时，这个信号没变)
        .LEDCtrl(LEDCtrl), //当为1的时候，需要输出到led灯中
        .SwitchCtrl(SwitchCtrl)//当为1的时候，需要从拨码开关中输入
    );



    ioWrite32 ioWrite(
        .writeData(write_dataToMemoryOrIo[23:0]),
        .clock(clock),
        .reset(rst),
        .ioWrite(IOWrite),
        .dataToio(led)
    );

endmodule
