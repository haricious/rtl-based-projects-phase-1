// 4X1 Multiplexer using boolean expressions
module mux_4x1(
    input n0,n1,n2,n3,
    input s0,s1,
    output y
);

    assign y = (~s0 & ~s1 & n0) |
           (~s0 &  s1 & n1) |
           ( s0 & ~s1 & n2) |
           ( s0 &  s1 & n3);

endmodule

// 4x1 Multiplexer using conditional logic ternary operator

module mux_4x1(
    input n0, n1, n2, n3,
    input s0, s1,
    output y
);

    assign y = s1 ? (s0?n3:n2) : (s0?n1:n0);

endmodule

// 4x1 Multiplexer using behavioural modelling using case

module mux_4x1(
    input [3:0]n,
    input [1:0]sel,
    output reg y
);

always @(*) begin

    case(sel) 

        2'b00: y = n[0];
        2'b01: y = n[1];
        2'b10: y = n[2];
        2'b11: y = n[3];
    
    default: y = 1'b0;
    endcase

    

end




