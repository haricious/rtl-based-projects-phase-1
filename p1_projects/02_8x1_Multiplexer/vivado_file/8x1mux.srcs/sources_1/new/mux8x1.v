`timescale 1ns / 1ps

// 8x1 mux using 2 4x1 mux and 1 2x1 mux using structural modelling

module mux4x1(
    input [3:0]in,
    input [1:0]s,
    output reg out
);
always @(*) begin
case(s)

2'b00: out = in[0];
2'b01: out = in[1];
2'b10: out = in[2];
2'b11: out = in[3];

default: out=1'b0;
endcase
end
endmodule



module mux8x1(
    input [7:0]n,
    input [2:0]sel,
    output y
);
wire w1, w2;

mux4x1 m1 (.in(n[3:0]), .s(sel[1:0]),.out(w1));
mux4x1 m2 (.in(n[7:4]), .s(sel[1:0]), .out(w2));


assign y = sel[2]?w2:w1;


endmodule