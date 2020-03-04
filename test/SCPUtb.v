`timescale 1ns / 1ps

module SPCUtb();
    reg clk;
    reg rst;

    wire RegDst;
    wire Branch;
    wire MemRead;
    wire MemtoReg;
    wire MemWrite;
    wire ALUSrc;
    wire RegWrite;
    wire Jump;
    wire EXTOp;
    wire [2:0] opcode;

    wire [31:0] ReadData1;
    wire [31:0] ReadData2;

    wire [31:0] instruct;
    wire [31:0] newPC;
    wire [31:0] PC;

    wire [31:0] MEMdataOut;

    wire [31:0] WriteData;

    SCPU scpu(
        .clk(clk),
        .rst(rst),
        .RegDst(RegDst),
        .Branch(Branch),
        .MemRead(MemtoReg),
        .MemtoReg(MemtoReg),
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc),
        .RegWrite(RegWrite),
        .Jump(Jump),
        .EXTOp(EXTOp),
        .opcode(opcode),
        .ReadData1(ReadData1),
        .ReadData2(ReadData2),
        .instruct(instruct),
        .newPC(newPC),
        .PC(PC),
        .MEMdataOut(MEMdataOut),
        .WriteData(WriteData)
    );


    initial begin
        clk = 1;
        rst = 0;
        
        clk = !clk;
        rst = 1;
        #5 rst = 0;
        forever #5
        begin
            clk = !clk;
        end
    end

endmodule // SPCUtb