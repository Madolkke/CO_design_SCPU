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
        //$readmemh("C:\\Users\\madol\\Desktop\\codesign_scpu\\test\\mipstest_extloop.dat", MEM);
        //$readmemh("C:\\Users\\madol\\Desktop\\codesign_scpu\\test\\mipstestloop_sim.dat", MEM);
        //$readmemh("C:\\Users\\madol\\Desktop\\codesign_scpu\\test\\mipstestloopjal_sim.dat", MEM);
        //$readmemh("C:\\Users\\madol\\Desktop\\codesign_scpu\\test\\bnetest.dat", MEM);
        $readmemh("C:\\Users\\madol\\Desktop\\codesign_scpu\\test\\3rdtest.dat", MEM);
        //$readmemh("C:\\Users\\madol\\Desktop\\codesign_scpu\\test\\4thtest.dat", MEM);
    end

    always @(*) begin
        inst = MEM[{2'b00, addr[31:2]}];
    end
endmodule // InstMEM