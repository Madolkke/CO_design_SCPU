`include "ctrl_encode_def.v"
module CTRL(
    input clk,
    input [5:0] INSTop,
    input [5:0] funct,
    output reg RegDst,
    output reg [1:0] MemRead,
    output reg MemtoReg,
    output reg [1:0] MemWrite,
    output reg ALUSrc,
    output reg RegWrite,
    output reg [1:0] EXTOp,
    output reg Link,
    output reg Shamt,
    output reg Unsigned,
    output reg [1:0] AddrSrc,
    output reg [3:0] opcode
);


    always @(*) begin
        RegDst = `False;
        ALUSrc = `False;
        MemtoReg = `False;
        RegWrite = `False;
        MemRead = `not_read;
        MemWrite = `not_write;
        EXTOp = `unsigned_ext;
        Link = `False;
        Shamt = `False;
        Unsigned = `False;
        AddrSrc = `origin_src;
        opcode = 4'b1111;
        case (INSTop)
            `slti_op: begin
                EXTOp = `signed_ext;
                RegWrite = `True;
                ALUSrc = `True;
                opcode = `ALU_SLT;
            end

            `lui_op: begin
                EXTOp = `lui_ext;
                RegWrite = `True;
                ALUSrc = `True;
                opcode = `ALU_IMM;
            end

            `bne_op: begin
                AddrSrc = `branch_src;
                RegDst = `True;
                opcode = `ALU_SUB;
            end

            `andi_op: begin
                RegWrite = `True;
                ALUSrc = `True;
                opcode = `ALU_AND;
            end


            `j_op: begin
                AddrSrc = `jump_src;
            end

            `jal_op: begin
                RegWrite = `True;
                AddrSrc = `jump_src;
                Link = `True;
            end

            `typer_op: begin
                RegDst = `True;
                RegWrite = `True;
                case (funct)
                    `sll_funct: begin
                        Shamt = `True;
                        EXTOp = `shamt_ext;
                    end
                    `srl_funct: begin
                        Shamt = `True;
                        EXTOp = `shamt_ext;
                    end
                    `sra_funct: begin
                        Shamt = `True;
                        EXTOp = `shamt_ext;
                    end
                    `jr_funct: begin
                        RegWrite = `False;
                        AddrSrc = `reg_src;
                    end
                    `jalr_funct: begin
                        AddrSrc = `reg_src;
                        Link = `True;
                    end
                endcase

                case (funct)
                    `add_funct:  opcode = `ALU_ADD;
                    `sub_funct:  opcode = `ALU_SUB;
                    `and_funct:  opcode = `ALU_AND;
                    `or_funct:   opcode = `ALU_OR;
                    `slt_funct:  opcode = `ALU_SLT;
                    `sltu_funct: opcode = `ALU_SLTU;
                    `addu_funct: opcode = `ALU_ADD;
                    `subu_funct: opcode = `ALU_SUB;
                    `sll_funct:  opcode = `ALU_SLL;
                    `srl_funct:  opcode = `ALU_SRL;
                    `sllv_funct: opcode = `ALU_SLL;
                    `srlv_funct: opcode = `ALU_SRL;
                    `jr_funct:   opcode = `ALU_NOP;
                    `jalr_funct: opcode = `ALU_NOP;
                    `nor_funct:  opcode = `ALU_NOR;
                    `xor_funct:  opcode = `ALU_XOR;
                    `sra_funct:  opcode = `ALU_SRA;
                    `srav_funct: opcode = `ALU_SRA;
                endcase
            end

            `ori_op: begin
                ALUSrc = `True;
                RegWrite = `True;
                opcode = `ALU_OR;
            end

            `addi_op: begin
                ALUSrc = `True;
                RegWrite = `True;
                EXTOp = `signed_ext;
                opcode = `ALU_ADD;
            end

            `lw_op: begin
                ALUSrc = `True;
                MemtoReg = `True;
                RegWrite = `True;
                MemRead = `read_word;
                opcode = `ALU_ADD;
            end

            `sw_op: begin
                ALUSrc = `True;
                MemWrite = `write_word;
                opcode = `ALU_ADD;
            end
            `lb_op: begin
                ALUSrc = `True;
                MemtoReg = `True;
                RegWrite = `True;
                MemRead = `read_byte;
                opcode = `ALU_ADD;
            end
            `lh_op: begin
                ALUSrc = `True;
                MemtoReg = `True;
                RegWrite = `True;
                MemRead = `read_halfword;
                opcode = `ALU_ADD;
            end
            `lbu_op: begin
                ALUSrc = `True;
                MemtoReg = `True;
                RegWrite = `True;
                Unsigned = `True;
                MemRead = `read_byte;
                opcode = `ALU_ADD;
            end
            `lhu_op: begin
                ALUSrc = `True;
                MemtoReg = `True;
                RegWrite = `True;
                MemRead = `read_halfword;
                Unsigned = `True;
                opcode = `ALU_ADD;
            end
            `sb_op: begin
                ALUSrc = `True;
                MemWrite = `write_byte;
                opcode = `ALU_ADD;
            end
            `sh_op: begin
                ALUSrc = `True;
                MemWrite = `write_halfword;
                opcode = `ALU_ADD;
            end

            `beq_op: begin
                AddrSrc = `branch_src;
            end 

        endcase
    end
endmodule // CTRL