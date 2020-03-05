module InstMEM(
    input [31:0] addr,
    output reg [31:0] inst
);
    reg [31:0] MEM [127:0];
    integer i;
    initial begin
        for (i = 0;i < 128;i = i + 1) begin
            MEM[i] = 32'b0;
        end
        $readmemh("C:\\Users\\madol\\Desktop\\codesign_scpu_with_jal\\test\\basic_test_true.dat", MEM);
    end

    always @(*) begin
        inst = MEM[{2'b00, addr[31:2]}];
    end
endmodule // InstMEM