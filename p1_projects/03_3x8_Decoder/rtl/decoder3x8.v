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
    output [7:0]y
);


always@(*) begin

case(x)
3'b000: y = 00000000;
3'b001: y = 00000001;
3'b010: y = 00000010;
3'b011: y = 00000011;
3'b100: y = 00000100;
3'b101: y = 00000101;
3'b110: y = 00000110;
3'b111: y = 00000111];




default: y = 8'b00000000;

endcase

end


endmodule