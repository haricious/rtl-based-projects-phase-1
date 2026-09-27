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

    

endmodule


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



