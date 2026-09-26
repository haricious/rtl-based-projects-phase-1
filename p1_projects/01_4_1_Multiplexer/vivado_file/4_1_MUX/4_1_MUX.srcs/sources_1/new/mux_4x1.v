`timescale 1ns / 1ps

module mux_4x1(
    input n0, n1, n2, n3,
    input s0, s1,
    output y
);

    assign y = s1 ? (s0?n3:n2) : (s0?n1:n0);

endmodule
