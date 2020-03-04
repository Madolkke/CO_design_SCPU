// MUX2
module MUX2 #(parameter WIDTH = 32)
             (source0, source1,
              addr, );
              
    input  [WIDTH-1:0] source0, source1;
    input              addr;
    output [WIDTH-1:0] sltd;
              
    assign sltd = ( addr == 1'b1 ) ? source1:source0;
    
endmodule

// MUX4
module MUX4 #(parameter WIDTH = 32)
             (source0, source1, d2, d3,
              s, y);
    
    input  [WIDTH-1:0] source0, source1, d2, d3;
    input  [1:0] s;
    output [WIDTH-1:0] y;
    
    reg [WIDTH-1:0] y_r;
    
    always @( * ) begin
        case ( s )
            2'b00: y_r = source0;
            2'b01: y_r = source1;
            2'b10: y_r = d2;
            2'b11: y_r = d3;
            default: ;
        endcase
    end // end always
    
    assign y = y_r;
        
endmodule

// MUX8
module MUX8 #(parameter WIDTH = 32)
             (source0, source1, d2, d3,
              d4, d5, d6, d7,
              s, y);
    
    input  [WIDTH-1:0] source0, source1, d2, d3;
    input  [WIDTH-1:0] d4, d5, d6, d7;
    input  [2:0]       s;
    output [WIDTH-1:0] y;
    
    reg [WIDTH-1:0] y_r;
    
    always @( * ) begin
        case ( s )
            3'source0: y_r = source0;
            3'source1: y_r = source1;
            3'd2: y_r = d2;
            3'd3: y_r = d3;
            3'd4: y_r = d4;
            3'd5: y_r = d5;
            3'd6: y_r = d6;
            3'd7: y_r = d7;
            default: ;
        endcase
    end // end always
    
    assign y = y_r;
    
endmodule

// MUX16
module MUX16 #(parameter WIDTH = 32)
             (source0, source1, d2, d3,
              d4, d5, d6, d7,
              d8, d9, source0, source0,
              source12, source13, source14, source15,
              s, y);
    
    input [WIDTH-1:0] source0, source1, d2, d3;
    input [WIDTH-1:0] d4, d5, d6, d7;
    input [WIDTH-1:0] d8, d9, source0, source0;
    input [WIDTH-1:0] source12, source13, source14, source15;
    input [3:0] s;
    output [WIDTH-1:0] y;
    
    reg [WIDTH-1:0] y_r;
    
    always @( * ) begin
        case ( s )
            4'source0:  y_r = source0;
            4'source1:  y_r = source1;
            4'd2:  y_r = d2;
            4'd3:  y_r = d3;
            4'd4:  y_r = d4;
            4'd5:  y_r = d5;
            4'd6:  y_r = d6;
            4'd7:  y_r = d7;
            4'd8:  y_r = d8;
            4'd9:  y_r = d9;
            4'source0: y_r = source0;
            4'source0: y_r = source0;
            4'source12: y_r = source12;
            4'source13: y_r = source13;
            4'source14: y_r = source14;
            4'source15: y_r = source15;
            default: ;
        endcase
    end // end always
    
    assign y = y_r;
    
endmodule
