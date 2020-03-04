`include "ctrl_encode_def.v"
module ALU_CTRL(
    input [1:0] ALUOp,
    input [5:0] funct,
    output reg [2:0] opcode 
);
    initial begin
        opcode = 3'b000;
    end
    always @(*) begin
        if (ALUOp == 2'b10) begin
            //typeR inst.
            case (funct)
                `add_funct:  opcode = `ALU_ADD;
                `sub_funct:  opcode = `ALU_SUB;
                `and_funct:  opcode = `ALU_AND;
                `or_funct:   opcode = `ALU_OR;
                `slt_funct:  opcode = `ALU_SLT;
                `sltu_funct: opcode = `ALU_SLTU;
                `addu_funct: opcode = `ALU_ADD;
                `subu_funct: opcode = `ALU_SUB;
                default:     opcode = 6'b00_0000;
            endcase
        end
        else if (ALUOp == 2'b00) begin
            //lw / sw inst.
            opcode = `ALU_ADD;
        end
        else if (ALUOp == 2'b01) begin
            //beq inst.
            opcode = `ALU_SUB;
        end
        else begin
            //ALUOp == 2'b11
            opcode = `ALU_NOP;
        end
    end

endmodule // ALU_CTRL


module CTRL(
    input clk,
    input [5:0] INSTop,
    input [5:0] funct,
    output reg RegDst,
    output reg Branch,
    output reg MemRead,
    output reg MemtoReg,
    output reg MemWrite,
    output reg ALUSrc,
    output reg RegWrite,
    output reg Jump,
    output reg EXTOp,
    output wire [2:0] opcode
);
    reg [1:0] ALUOp;
    ALU_CTRL alu_ctrl(.ALUOp(ALUOp), .funct(funct), .opcode(opcode));
    always @(*) begin
        case (INSTop)
            `j_op: begin
                ALUOp = 2'b00;
                RegDst = `False;
                ALUSrc = `False;
                MemtoReg = `False;
                RegWrite = `False;
                MemRead = `False;
                MemWrite = `False;
                Branch = `False;
                Jump = `True;
                EXTOp = `False;
            end
            `jal_op: begin
                
            end
            `typer_op: begin
                ALUOp = 2'b10;
                RegDst = `True;
                ALUSrc = `False;
                MemtoReg = `False;
                RegWrite = `True;
                MemRead = `False;
                MemWrite = `False;
                Branch = `False;
                Jump = `False;
                EXTOp = `False;
            end
            `ori_op: begin
                ALUOp = 2'b00;
                RegDst = `False;
                ALUSrc = `True;
                MemtoReg = `False;
                RegWrite = `True;
                MemRead = `False;
                MemWrite = `False;
                Branch = `False;
                Jump = `False;
                EXTOp = `False;
            end
            `addi_op: begin
                ALUOp = 2'b00;
                RegDst = `False;
                ALUSrc = `True;
                MemtoReg = `False;
                RegWrite = `True;
                MemRead = `False;
                MemWrite = `False;
                Branch = `False;
                Jump = `False;
                EXTOp = `True;
            end
            `lw_op: begin
                ALUOp = 2'b00;
                RegDst = `False;
                ALUSrc = `True;
                MemtoReg = `True;
                RegWrite = `True;
                MemRead = `True;
                MemWrite = `False;
                Branch = `False;
                Jump = `False;
                EXTOp = `False;
            end
            `sw_op: begin
                ALUOp = 2'b00;
                RegDst = `Undefined;
                ALUSrc = `True;
                MemtoReg = `Undefined;
                RegWrite = `False;
                MemRead = `False;
                MemWrite = `True;
                Branch = `False;
                Jump = `False;
                EXTOp = `False;
            end
            `beq_op: begin
                ALUOp = 2'b01;
                RegDst = `Undefined;
                ALUSrc = `False;
                MemtoReg = `Undefined;
                RegWrite = `False;
                MemRead = `False;
                MemWrite = `False;
                Branch = `True;
                Jump = `False;
                EXTOp = `False;
            end 
        endcase
    end
endmodule // CTRL