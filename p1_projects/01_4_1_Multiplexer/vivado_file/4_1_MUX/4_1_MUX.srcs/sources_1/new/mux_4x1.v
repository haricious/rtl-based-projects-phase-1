`timescale 1ns / 1ps
// // 4x1 Multiplexer using gates
module mux_4x1(
    input n0,n1,n2,n3,
    input s0,s1,
    output y
);

// internal wires

wire w1,w2,w3,w4; // to connect the input and select lines
wire x1,x2; // for not gates - s0, s1

//not gates

not g1(x1, s0);
not g2(x2, s1);


// and gates
and a1(w1,x2, x1,n0);
and a2(w2, x2, s0,n1);
and a3(w3,s1,x1,n2 );
and a4(w4,s1,s0,n3);

//or gate
or o1(y,w1,w2,w3,w4);

endmodule
