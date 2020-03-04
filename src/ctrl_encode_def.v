// NPC control signal
`define NPC_PLUS4   2'b00
`define NPC_BRANCH  2'b01
`define NPC_JUMP    2'b10


// ALU control signal
`define ALU_NOP   3'b000 
`define ALU_ADD   3'b001
`define ALU_SUB   3'b010 
`define ALU_AND   3'b011
`define ALU_OR    3'b100
`define ALU_SLT   3'b101
`define ALU_SLTU  3'b110

// CTRL op signal
`define typer_op 6'b00_0000
`define addi_op  6'b00_1000
`define ori_op   6'b00_1101
`define lw_op    6'b10_0011
`define sw_op    6'b10_1011
`define beq_op   6'b00_0100
`define j_op     6'b00_0010
`define jal_op   6'b00_0011

// CTRL funct signal
`define add_funct  6'b10_0000
`define sub_funct  6'b10_0010
`define and_funct  6'b10_0100
`define or_funct   6'b10_0101
`define slt_funct  6'b10_1010
`define sltu_funct 6'b10_1011
`define addu_funct 6'b10_0001
`define subu_funct 6'b10_0011

//1 bit parameters
`define True 1'b1
`define False 1'b0
`define Undefined 1'b0

