module DataMEM(
    input clk,
    input [31:0] MemAddr,
    input [31:0] dataIn,
    input MemWrite,
    input MemRead,
    output reg [31:0] dataOut
);

reg [31:0] MEM [127:0];
integer i;
initial begin
    for (i = 0;i < 128;i = i + 1) begin
            MEM[i] = 32'b0;
        end
end

always @(*) begin
    if (MemRead) begin
        dataOut = MEM[MemAddr];
    end
end

always @(negedge clk) begin
    if (MemWrite) begin
        MEM[MemAddr] = dataIn;
    end
end

endmodule // DataMEM