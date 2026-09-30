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

// imma use 1 process methodology for seq rst + output logic + next state logic all in one
always@(posedge clk) begin
nstate=s0;
//reset logic
if(rst)
    state<=s0;
else begin
    state<=nstate;
    case(state)
    s0: begin

    end 
    s1: begin

    end
    s2: begin

    end
    s3: begin
        
    end



    default: nstate=s0; dout=0;
    endcase
end 





end



endmodule
