module selfAdder(
    input [31:0] pcIn,
    output reg [31:0] pcOut
);
    
    always @(*) begin
        pcOut = pcIn + 32'h0000_0004;
    end
endmodule // Adder