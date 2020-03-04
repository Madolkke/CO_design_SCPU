module RF(
    input clk,
    input rst,
    input RegWrite,
    input [4:0] ReadAddr1, ReadAddr2, WriteAddr,
    input [31:0] WriteData,
    output [31:0] ReadData1, ReadData2
);
    reg [31:0] rf[31:0];
    integer i;
    always @(posedge clk, posedge rst) begin
        if (rst) begin
            for(i = 0; i < 32; i = i + 1)begin
                rf[i] <= 0;
            end
        end
        else begin
            if (RegWrite) begin
                rf[WriteAddr] <= WriteData;
            end
        end
    end
    assign ReadData1 = (ReadAddr1 != 0) ? rf[ReadAddr1] : 0;
    assign ReadData2 = (ReadAddr2 != 0) ? rf[ReadAddr2] : 0;
    
endmodule // RF
