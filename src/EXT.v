`include "ctrl_encode_def.v"
module EXT(
    input [15:0] Imm16,
    input [1:0] EXTOp,
    output reg [31:0] Imm32
);
    always @(*) begin
        case (EXTOp)
            `unsigned_ext: begin
                Imm32 = {16'd0, Imm16};
            end
            `signed_ext: begin
                Imm32 = {{16{Imm16[15]}}, Imm16};
            end
            `shamt_ext: begin
                Imm32 = {27'b0, Imm16[10:6]};
            end 
            `lui_ext: begin
                Imm32 = {Imm16, 16'd0};
            end
        endcase
    end
       
endmodule
