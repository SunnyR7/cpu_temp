module cputop (clk,switch,reset,uart_stage,led,confirm,confirm_a,confirm_b,rx,tx,key_backspace,row,col_n,tube_char,tube_switch);
    input clk; //时钟信号
    // input confirm;
    input[23:0] switch; //24个拨码开关
    input reset; //重置按键
    input uart_stage; //uart状态按键
    output[23:0] led; //led灯
    input confirm; //确认按键1
    input confirm_a; //确认按键2
    input confirm_b; //确认按键3
    input rx; //uart的输入
    output tx; //uart的输出
    input key_backspace; //退格键按键
    input[3:0] row; //矩阵键盘
    output  [3:0] col_n; //矩阵键盘
    output [7:0] tube_char; //七段数码管
    output [7:0] tube_switch; //七段数码管

    wire [15:0] out_value_right;//io选择后的信号
    wire [2:0] out_value_left;//io选择后的按键

    wire rst;//为1则进入reset状态，uart状态下同时reset active high
    wire start_pg;//为1则进入uart状态 active high
    
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
    wire[31:0] hi;//mul,div使用的寄存器
    wire[31:0] lo;

    //dmemory32
    wire[31:0] read_dataFromMemory; 
    //从DATA RAM or I/O port取出的数据,写寄存器的数据mem_data

    //clock
    wire clock;
    wire clock_uart;
    frequency #(10) uart_clock(clk, 1'b1,clock_uart);
    cpuclk cpu_clock( //生成cpu用的时钟信号的ip核模块
        .clk_in1(clk), 
        .clk_out1(clock)
    );

    //MemOrIO
    wire LEDCtrl;//led片选信号
    wire SwitchCtrl;//Switch片选信号
    wire [31:0] read_dataFromMemoryOrIo; //要写入decoder的值
    wire [31:0] write_dataToMemoryOrIo;  //写给要写入decoder的值的值


    //uart
    // UART Programmer Pinouts
    wire upg_clk_o;
    wire upg_wen_o; //Uart write out enable
    wire upg_done_o; //Uart rx data have done
    //data to which memory unit of program_rom/dmemory32
    wire [14:0] upg_adr_o;
    //data to program_rom or dmemory32
    wire [31:0] upg_dat_o;

    wire confirm_key_value;//确认用例编号键
    wire confirm_a_key_value;//确认a值键
    wire confirm_b_key_value;//确认b值键

    key_debounce key_confirm(
    .sys_clk(clk),
    .key(confirm), 
    .key_value(confirm_key_value) 
    );
    key_debounce key_confirm_a(
    .sys_clk(clk),
    .key(confirm_a), 
    .key_value(confirm_a_key_value) 
    );
    key_debounce key_confirm_b(
    .sys_clk(clk),
    .key(confirm_b), 
    .key_value(confirm_b_key_value) 
    );

    ioRead(
        .clk(clk),
        .out_value_right(out_value_right),
        .out_value_left(out_value_left),
        .sw({switch[23:21],rst|~switch[20],switch[19:0]}),
        .key_backspace(key_backspace),
        .row(row),
        .col_n(col_n),
        .tube_char(tube_char),
        .tube_switch(tube_switch)
    );

    stage_control stage_controll(
        .clk(clk),
        .reset(reset),
        .uart_stage(uart_stage),
        .rst(rst),
        .start_pg(start_pg)
    );
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
        .PC_plus_4(branch_base_addr),
        .hi(hi),
        .lo(lo)
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
        .opcplus4(link_addr),
        .hi_from_ALU(hi),
        .lo_from_ALU(lo)
    );

    MemOrIO memOrio( 
        .mRead(MemRead), 
        .mWrite(MemWrite), 
        .ioRead(IORead), 
        .ioWrite(IOWrite),
        .addr_in(ALU_Result), 
        .m_rdata(read_dataFromMemory), //从mem过来的data
        .io_rdata({8'b0000_0000,out_value_left,confirm_key_value,confirm_a_key_value,confirm_b_key_value,switch[17:16],out_value_right}),//从io过来的data 
        .r_wdata(read_dataFromMemoryOrIo), //写回给decoder的值 
        .r_rdata(read_data_2), //从decoder中过来的data
        .write_data(write_dataToMemoryOrIo),//写回给io或者mem中的值，就是上面的r_rdata(需要用这个信号时，这个信号没变)
        .LEDCtrl(LEDCtrl), //当为1的时候，需要输出到led灯中
        .SwitchCtrl(SwitchCtrl)//当为1的时候，需要从拨码开关中输入
    );


    //第18个是回文亮灯
    ioWrite32 ioWrite(
        .writeData({rst,start_pg,(confirm_key_value|confirm_a_key_value|confirm_b_key_value)&~rst,switch[20]&~rst,write_dataToMemoryOrIo[19:0]}),//写给io的值
        .clock(clock),
        .reset(rst),
        .ioWrite(IOWrite),
        .stage_io(led[23:20]),
        .dataToio(led[19:0])
    );

endmodule