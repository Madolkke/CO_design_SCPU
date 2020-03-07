module SCPU(
    input clk,
    input rst,

    //ctrl signal output BEGIN-----------
    output RegDst,
    output Branch,
    output MemRead,
    output MemtoReg,
    output MemWrite,
    output ALUSrc,
    output RegWrite,
    output Jump,
    output EXTOp,
    output Link,
    output [2:0] opcode,
    //-------------ctrl singal output END
    
    //data read by regfile BEGIN---------
    output [31:0] ReadData1,
    output [31:0] ReadData2,
    //-----------data read by regfile END
    
    output [31:0] instruct,
    output [31:0] newPC,
    output [31:0] PC,

    //output data of MEM BEGIN-----
    output [31:0] MEMdataOut,
    //--------------------------END

    //data written back to RF BEGIN---
    output [31:0] WriteData
    //---------------------Data WB END
    
);
    wire [31:0] PCadd4;
    //splited instruct signal BEGIN----------
    wire [5:0] INSTop;
    wire [4:0] rsReg;
    wire [4:0] rtReg;
    wire [4:0] rdReg;
    wire [5:0] funct;
    wire [15:0] Imm16;
    wire [25:0] jAddr;
    //------------splited instruct signal END

    //this signal is used to choose the target write_register in regfile :BEGIN----
        //it' s seleted by the [reg_dst_mux] component and used by [RF]
    wire [4:0] regWriteAddr;
    //-------------------------------------------------------------------------:END

    //this signal is the 32 bits iNumber extended by the extender BEGIN------
    wire [31:0] Imm32;
    //--------------------------------------------------------------Imm32 END


    //this signal is the source selected by [alu_src_mux2] BEGIN-----
    wire [31:0] ALUSrc_data;
    //------------------------------------------------------------END
    
    //this signal is the result of ALU calculated BEGIN-----
    wire [31:0] ALU_result;
    //---------------------------------------------------END
    
    //the zero signal of ALU BEGIN-------
    wire zero_signal;
    //--------------------zero signal END
    
    
    

    //THE ADDRESS CONTROL PART WILL BEGIN IN THIS BLOCK
    
    
    
    PC pc_reg(
        .clk(clk),
        .rst(rst),
        .NPC(newPC),
        .PC(PC)
    );

    selfAdder self_adder(
        .pcIn(PC),
        .pcOut(PCadd4)
    );
    wire [31:0]jumpAddr;
    assign jumpAddr = {PCadd4[31:28], jAddr, 2'b00};

    wire [31:0] branchOffset;
    assign branchOffset = {Imm32[29:0], 2'b00};

    wire [31:0] branchPC;
    branchAdder branch_adder(
        .extendedInum(branchOffset),
        .currentPC(PCadd4),
        .branchPC(branchPC)
    );

    wire branch_select_signal;
    wire [31:0] branch_result;
    assign branch_select_signal = Branch & zero_signal;
    
    MUX2 branch_mux2(
        .source0(PCadd4),
        .source1(branchPC),
        .addr(branch_select_signal),
        .sltd(branch_result)
    );

    
    MUX2 jump_mux2(
        .source0(branch_result),
        .source1(jumpAddr),
        .addr(Jump),
        .sltd(newPC)
    );

    //AND END HERE

    CTRL control_unit(
        .clk(clk),
        .INSTop(INSTop),
        .funct(funct),
        .RegDst(RegDst),
        .Branch(Branch),
        .MemRead(MemRead),
        .MemtoReg(MemtoReg),
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc),
        .RegWrite(RegWrite),
        .Jump(Jump),
        .EXTOp(EXTOp),
        .Link(Link),
        .opcode(opcode)
    );

    InstMEM inst_mem(
        .addr(PC),
        .inst(instruct)
    );

    InstSpliter inst_spliter(
        .inst(instruct),
        .INSTop(INSTop),
        .rsReg(rsReg),
        .rtReg(rtReg),
        .rdReg(rdReg),
        .funct(funct),
        .Imm16(Imm16),
        .jAddr(jAddr)
    );

    wire [4:0] NormalInst_reg_src;
    MUX2_5b reg_dst_mux2(
        .source0(rtReg),
        .source1(rdReg),
        .addr(RegDst),
        .sltd(NormalInst_reg_src)
    );
    
    wire [4:0] Jal_reg_src;
    assign Jal_reg_src = 5'b11111;

    MUX2_5b link_mux2(
        .source0(NormalInst_reg_src),
        .source1(Jal_reg_src),
        .addr(Link),
        .sltd(regWriteAddr)
    );

    wire [31:0] memORalu_src_data;
    
    MUX2 write_data_mux2(
        .source0(memORalu_src_data),
        .source1(PCadd4),
        .addr(Link),
        .sltd(WriteData)
    );


    RF regfile(
        .clk(clk),
        .rst(rst),
        .RegWrite(RegWrite),
        .ReadAddr1(rsReg),
        .ReadAddr2(rtReg),
        .WriteAddr(regWriteAddr),
        .WriteData(WriteData),
        .ReadData1(ReadData1),
        .ReadData2(ReadData2)
    );

    EXT extender(
        .Imm16(Imm16),
        .EXTOp(EXTOp),
        .Imm32(Imm32)
    );

    MUX2 alu_src_mux2(
        .source0(ReadData2),
        .source1(Imm32),
        .addr(ALUSrc),
        .sltd(ALUSrc_data)
    );

    ALU main_alu(
        .A(ReadData1),
        .B(ALUSrc_data),
        .opcode(opcode),
        .C(ALU_result),
        .Zero(zero_signal)
    );

    DataMEM data_mem(
        .clk(clk),
        .MemAddr(ALU_result),
        .dataIn(ReadData2),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .dataOut(MEMdataOut)
    );

    MUX2 mem_to_reg_mux2(
        .source0(ALU_result),
        .source1(MEMdataOut),
        .addr(MemtoReg),
        .sltd(memORalu_src_data)
    );




endmodule // SCPUinput clk,

