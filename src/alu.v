`include "ctrl_encode_def.v"

module ALU(A, B, opcode, C, Zero);
           
   input  signed [31:0] A, B;
   input         [3:0]  opcode;
   output signed [31:0] C;
   output Zero;
   //left right shift and nor
   reg [31:0] C;

       
   always @( * ) begin
      case ( opcode )
          `ALU_NOP:  C = A;                          // NOP
          `ALU_ADD:  C = A + B;                      // ADD
          `ALU_SUB:  C = A - B;                      // SUB
          `ALU_AND:  C = A & B;                      // AND/ANDI
          `ALU_OR:   C = A | B;                      // OR/ORI
          `ALU_SLT:  C = (A < B) ? 32'd1 : 32'd0;    // SLT/SLTI
          `ALU_SLTU: C = ({1'b0, A} < {1'b0, B}) ? 32'd1 : 32'd0;
          `ALU_SLL:  C = B << A;
          `ALU_SRL:  C = B >> A;
          `ALU_NOR:  C = ~(A | B);
          `ALU_IMM:  C = B;
          `ALU_XOR:  C = A ^ B;
          `ALU_SRA:  C = B >>> A;
          default:   C = A;                          // Undefined
      endcase
   end // end always
   
   assign Zero = (C == 32'b0);

endmodule
    
