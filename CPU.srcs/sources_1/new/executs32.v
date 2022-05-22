`timescale 1ns / 1ps

module executs32(Read_data_1,Read_data_2,Sign_extend,Function_opcode,Exe_opcode,ALUOp,
                 Shamt,ALUSrc,I_format,Zero,Jr,Sftmd,ALU_Result,Addr_Result,PC_plus_4,hi,lo
                 );
    input[31:0]  Read_data_1;		// �����뵥Ԫ��Read_data_1����
    input[31:0]  Read_data_2;		// �����뵥Ԫ��Read_data_2����
    input[31:0]  Sign_extend;		// �����뵥Ԫ������չ���������
    input[5:0]   Function_opcode;  	// ȡָ��Ԫ����r-����ָ�����,r-form instructions[5:0]
    input[5:0]   Exe_opcode;  		// ȡָ��Ԫ���Ĳ�����[31:26]
    input[1:0]   ALUOp;             // ��R-���ͻ�I_format=1ʱλ1����bitλ��Ϊ1,  beq��bneָ����λ0����bitλ��Ϊ1
    input[4:0]   Shamt;             // ����ȡָ��Ԫ��instruction[10:6]��ָ����λ����
    input  		 Sftmd;            // ���Կ��Ƶ�Ԫ�ģ���������λָ��
    input        ALUSrc;            // ���Կ��Ƶ�Ԫ�������ڶ�������������������beq��bne���⣩
    input        I_format;          // ���Կ��Ƶ�Ԫ�������ǳ�beq, bne, LW, SW֮���I-����ָ��
    input        Jr;               // ���Կ��Ƶ�Ԫ��������JRָ��
    output     Zero;              // Ϊ1��������ֵΪ0  branch
    output reg [31:0] ALU_Result;        // ��������ݽ��    
    output [31:0] Addr_Result;		// ����ĵ�ַ���     
    output reg [31:0] hi;           //ָ����չmul/div�õ���Ҫд��hi�Ĵ�����ֵ 
    output reg [31:0] lo;           //ָ����չmul/div�õ���Ҫд��lo�Ĵ�����ֵ
    input[31:0]  PC_plus_4;         // ����ȡָ��Ԫ��PC+4

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
        3'b101: ALU_output_mux = ~(Ainput | Binput);//lui��������
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
            ALU_Result = (ALU_output_mux[31] ==1)? 1'b1 : 1'b0;//�ж����λ
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
