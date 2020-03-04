module InstSpliter(
    input [31:0] inst,
    output reg [5:0]INSTop,
    output reg [4:0] rsReg,
    output reg [4:0] rtReg,
    output reg [4:0] rdReg,
    output reg [5:0] funct,
    output reg [15:0] Imm16,
    output reg [25:0] jAddr
);
    initial begin
        INSTop = 6'b00_0000;
        rsReg = 5'b0_0000;
        rtReg = 5'b0_0000;
        rdReg = 5'b0_0000;
        funct = 6'b00_0000;
        Imm16 = 16'h00;
        jAddr = 0;
    end

    always @(*) begin
        INSTop = inst[31:26];
        rsReg = inst[25:21];
        rtReg = inst[20:16];
        rdReg = inst[15:11];
        funct = inst[5:0];
        Imm16 = inst[15:0];
        jAddr = inst[25:0];
    end
    

endmodule // InstSpliter