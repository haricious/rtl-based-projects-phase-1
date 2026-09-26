`timescale 1ns / 1ps
// 4X1 Multiplexer using boolean expressions
module mux_4x1(
    input n0,n1,n2,n3,
    input s0,s1,
    output y
);

    assign y = (~s1 & ~s0 & n0) |
           (~s1 &  s0 & n1) |
           ( s1 & ~s0 & n2) |
           ( s1 &  s0 & n3);

endmodule
