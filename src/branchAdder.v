module branchAdder(
    input [31:0] extendedInum,
    input [31:0] currentPC,
    output reg [31:0] branchPC
);
    always @(*) begin
        branchPC = extendedInum + currentPC;
    end

endmodule