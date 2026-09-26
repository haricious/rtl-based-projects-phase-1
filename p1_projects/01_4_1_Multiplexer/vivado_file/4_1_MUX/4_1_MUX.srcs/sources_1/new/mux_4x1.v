`timescale 1ns / 1ps
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
