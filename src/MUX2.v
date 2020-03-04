module MUX2(
    input [31:0] source0, 
    input [31:0] source1,
    input addr, 
    output [31:0] sltd
    );
    assign sltd = ( addr == 1'b1 ) ? source1 : source0;
endmodule