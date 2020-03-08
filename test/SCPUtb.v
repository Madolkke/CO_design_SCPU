`timescale 1ns / 1ps

module SPCUtb();
    reg clk;
    reg rst;

    wire RegDst;
    wire MemRead;
    wire MemtoReg;
    wire MemWrite;
    wire ALUSrc;
    wire RegWrite;
    wire Link;
    wire Shamt;
    wire [1:0] AddrSrc;
    wire [1:0] EXTOp;
    wire [3:0] opcode;

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
        .MemRead(MemtoReg),
        .MemtoReg(MemtoReg),
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc),
        .AddrSrc(AddrSrc),
        .Shamt(Shamt),
        .RegWrite(RegWrite),
        .Link(Link),
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