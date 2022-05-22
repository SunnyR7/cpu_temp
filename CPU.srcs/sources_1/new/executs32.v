`timescale 1ns / 1ps

module executs32(Read_data_1,Read_data_2,Sign_extend,Function_opcode,Exe_opcode,ALUOp,
                 Shamt,ALUSrc,I_format,Zero,Jr,Sftmd,ALU_Result,Addr_Result,PC_plus_4,hi,lo
                 );
    input[31:0]  Read_data_1;		// 从译码单元的Read_data_1中来
    input[31:0]  Read_data_2;		// 从译码单元的Read_data_2中来
    input[31:0]  Sign_extend;		// 从译码单元来的扩展后的立即数
    input[5:0]   Function_opcode;  	// 取指单元来的r-类型指令功能码,r-form instructions[5:0]
    input[5:0]   Exe_opcode;  		// 取指单元来的操作码[31:26]
    input[1:0]   ALUOp;             // 是R-类型或I_format=1时位1（高bit位）为1,  beq、bne指令则位0（低bit位）为1
    input[4:0]   Shamt;             // 来自取指单元的instruction[10:6]，指定移位次数
    input  		 Sftmd;            // 来自控制单元的，表明是移位指令
    input        ALUSrc;            // 来自控制单元，表明第二个操作数是立即数（beq，bne除外）
    input        I_format;          // 来自控制单元，表明是除beq, bne, LW, SW之外的I-类型指令
    input        Jr;               // 来自控制单元，表明是JR指令
    output     Zero;              // 为1表明计算值为0  branch
    output reg [31:0] ALU_Result;        // 计算的数据结果    
    output [31:0] Addr_Result;		// 计算的地址结果     
    output reg [31:0] hi;           //指令拓展mul/div用到的要写入hi寄存器的值 
    output reg [31:0] lo;           //指令拓展mul/div用到的要写入lo寄存器的值
    input[31:0]  PC_plus_4;         // 来自取指单元的PC+4

    wire[31:0] Ainput,Binput;
    wire[5:0] Exe_code;
    wire[2:0] ALU_ctl;
    wire[2:0] Sftm;
    reg[31:0] Shift_Result;
    reg[31:0] ALU_output_mux;
    wire[32:0] Branch_Addr;
   //multi
    reg[63:0] product;

    assign Ainput = Read_data_1;
    assign Binput = (ALUSrc == 1'b0)? Read_data_2 : Sign_extend;
    assign Exe_code = (I_format == 1'b0)?Function_opcode:{3'b000,Exe_opcode[2:0]};
    assign ALU_ctl[0] = (Exe_code[0] | Exe_code[3]) & ALUOp[1];
    assign ALU_ctl[1] = (!Exe_code[2])|(!ALUOp[1]);
    assign ALU_ctl[2] = (Exe_code[1] & ALUOp[1]) | ALUOp[0];
    assign Sftm = Function_opcode[2:0];

    always @(Function_opcode,Exe_opcode)begin
        if(Exe_opcode == 6'b000000) begin
            if(Function_opcode == 6'b011001)begin 
                product = Ainput*Binput;
                hi = product[63:32];
                lo = product[31:0]; 
                end //011001 multu
            else if(Function_opcode == 6'b011011)begin 
                lo = Ainput / Binput;
                hi = Ainput % Binput;
             end //011011 divu
        end
    end



    always@(ALU_ctl or Ainput or Binput)begin
        case(ALU_ctl)
        3'b000: ALU_output_mux = Ainput & Binput;            
        3'b001: ALU_output_mux = Ainput | Binput;
        3'b010: ALU_output_mux = $signed(Ainput) + $signed(Binput);
        3'b011: ALU_output_mux = Ainput + Binput; //
        3'b100: ALU_output_mux = Ainput ^ Binput;
        3'b101: ALU_output_mux = ~(Ainput | Binput);//lui单独处理
        3'b110: ALU_output_mux = $signed(Ainput) - $signed(Binput);
        3'b111: ALU_output_mux = Ainput - Binput;
        default: ALU_output_mux = 32'b0;
        endcase
    end

    always@* begin
        if(Sftmd) begin
            case(Sftm[2:0])
                3'b000: Shift_Result = Binput << Shamt;
                3'b010: Shift_Result = Binput >> Shamt;
                3'b100: Shift_Result = Binput << Ainput;
                3'b110: Shift_Result = Binput >> Ainput;
                3'b011: Shift_Result = $signed(Binput) >>> Shamt;
                3'b111: Shift_Result = $signed(Binput) >>> Ainput;
                default: Shift_Result = Binput;
            endcase
        end
        else Shift_Result = Binput;
    end

    always @(*) begin
        if(((ALU_ctl == 3'b111) && (Exe_code[3] == 1)) || (I_format && ALU_ctl[2:1] == 2'b11)) begin   
            ALU_Result = (ALU_output_mux[31] ==1)? 1'b1 : 1'b0;//判断最高位
        end
        else if(ALU_ctl == 3'b101 && I_format == 1) begin
            ALU_Result = {Binput[15:0], 16'b0};
        end
        else if(Sftmd == 1) begin ALU_Result = Shift_Result;  end
        else ALU_Result = ALU_output_mux;
    end

    assign Zero = (ALU_output_mux == 32'b0)? 1'b1 : 1'b0; 
    assign Branch_Addr = PC_plus_4 + (Sign_extend << 2);
    assign Addr_Result = Branch_Addr[31:0];
endmodule
