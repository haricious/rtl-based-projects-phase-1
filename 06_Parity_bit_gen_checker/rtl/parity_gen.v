`timescale 1ns/1ps

module parity_gen(
    input [7:0] data,
    output parity_bit
);

assign parity_bit = ^data;



endmodule