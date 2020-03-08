// NPC control signal
`define NPC_PLUS4   2'b00
`define NPC_BRANCH  2'b01
`define NPC_JUMP    2'b10


// ALU control signal
`define ALU_AND   4'b0000
`define ALU_OR    4'b0001
`define ALU_ADD   4'b0010
`define ALU_SLL   4'b0011
`define ALU_SRL   4'b0100
`define ALU_NOR   4'b0101
`define ALU_SUB   4'b0110
`define ALU_SLT   4'b0111
`define ALU_SLTU  4'b1000
`define ALU_IMM   4'b1001
`define ALU_NOP   4'b1111

// CTRL op signal
`define typer_op 6'b00_0000
`define j_op     6'b00_0010
`define jal_op   6'b00_0011
`define beq_op   6'b00_0100
`define bne_op   6'b00_0101
`define addi_op  6'b00_1000
`define slti_op  6'b00_1010
`define andi_op  6'b00_1100
`define ori_op   6'b00_1101
`define lui_op   6'b00_1111
`define lw_op    6'b10_0011
`define sw_op    6'b10_1011




// CTRL funct signal
`define sll_funct  6'b00_0000
`define srl_funct  6'b00_0010
`define sllv_funct 6'b00_0100
`define srlv_funct 6'b00_0110
`define jr_funct   6'b00_1000
`define jalr_funct 6'b00_1001
`define add_funct  6'b10_0000
`define addu_funct 6'b10_0001
`define sub_funct  6'b10_0010
`define and_funct  6'b10_0100
`define or_funct   6'b10_0101
`define nor_funct  6'b10_0111
`define slt_funct  6'b10_1010
`define sltu_funct 6'b10_1011
`define subu_funct 6'b10_0011

//1 bit parameters
`define True 1'b1
`define False 1'b0
`define Undefined 1'b0

//Extend mode
`define unsigned_ext 2'b00
`define signed_ext   2'b01
`define shamt_ext    2'b10
`define lui_ext      2'b11



//Address Source
`define origin_src 2'b00
`define branch_src 2'b01
`define jump_src   2'b10
`define reg_src    2'b11

