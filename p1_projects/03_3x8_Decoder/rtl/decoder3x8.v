`timescale 1ns / 1ps
// decoder using boolean expressions

module decoder3x8(
    input [2:0]x,
    output [7:0]y
);


assign y[0] = (~x[2]&~x[1]&~x[0]);
assign y[1] = (~x[2]&~x[1]&x[0]);
assign y[2] = (~x[2]&x[1]&~x[0]);
assign y[3] = (~x[2]&x[1]&x[0]);
assign y[4] = (x[2]&~x[1]&~x[0]);
assign y[5] = (x[2]&~x[1]&x[0]);
assign y[6] = (x[2]&x[1]&~x[0]);
assign y[7] = (x[2]&x[1]&x[0]);



endmodule

// decoder using case

module decoder3x8(
    input [2:0]x,
    output reg [7:0]y
);


always@(*) begin

case(x)
3'b000: y = 8'b00000001;
3'b001: y = 8'b00000010;
3'b010: y = 8'b00000100;
3'b011: y = 8'b00001000;
3'b100: y = 8'b00010000;
3'b101: y = 8'b00100000;
3'b110: y = 8'b01000000;
3'b111: y = 8'b10000000;

default: y = 8'b00000000;

endcase

end


endmodule