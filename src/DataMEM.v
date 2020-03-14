`include "ctrl_encode_def.v"
module DataMEM(
    input clk,
    input [31:0] MemAddr,
    input [31:0] dataIn,
    input [1:0] MemWrite,
    input [1:0] MemRead,
    input Unsigned,
    output reg [31:0] dataOut
);

reg [7:0] MEM [511:0];
reg [7:0] mid;
integer i;
initial begin
    mid = 8'b0;
    for (i = 0;i < 512;i = i + 1) begin
            MEM[i] = 8'b0;
        end
end

always @(*) begin
    if (MemRead == `read_word) begin
        dataOut = {MEM[MemAddr + 2'b11], MEM[MemAddr + 2'b10], MEM[MemAddr + 2'b01], MEM[MemAddr]};
    end
    else if (MemRead == `read_halfword) begin
        mid = MEM[MemAddr + 2'b01];
        dataOut = {(Unsigned ? (16'b0) : ({16{mid[7]}})), mid, MEM[MemAddr]};
    end 
    else if (MemRead == `read_byte) begin
        mid = MEM[MemAddr];
        dataOut = {(Unsigned ? (27'b0) : ({27{mid[7]}})), mid};
    end
end

always @(negedge clk) begin
    if (MemWrite == `write_word) begin
        MEM[MemAddr] = dataIn[7:0];
        MEM[MemAddr + 2'b01] = dataIn[15:8];
        MEM[MemAddr + 2'b10] = dataIn[23:16];
        MEM[MemAddr + 2'b11] = dataIn[31:24];
    end 
    else if (MemWrite == `write_halfword) begin
        MEM[MemAddr] = dataIn[7:0];
        MEM[MemAddr + 2'b01] = dataIn[15:8];
    end
    else if (MemWrite == `write_byte) begin
        MEM[MemAddr] = dataIn[7:0];
    end
end

endmodule // DataMEM