module MUX2_5b(
    input [4:0] source0, 
    input [4:0] source1,
    input addr, 
    output [4:0] sltd
    );

    assign sltd = ( addr == 1'b1 ) ? source1 : source0;
    
endmodule