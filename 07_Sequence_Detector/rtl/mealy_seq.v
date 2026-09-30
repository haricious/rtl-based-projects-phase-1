`timescale 1ns / 1ps


module mealy_seq(
    input din,
    input clk,
    input rst,
    output reg dout
);
// 4 states required for mealy machine
reg [2:0]state, nstate;

parameter s0=3'b000;
parameter s1=3'b001;
parameter s2=3'b010;
parameter s3=3'b011;




endmodule
