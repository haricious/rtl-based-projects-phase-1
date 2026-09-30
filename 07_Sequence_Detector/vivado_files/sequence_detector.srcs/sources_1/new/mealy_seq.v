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


always@(posedge clk) begin
//seq reset logic
if(rst) begin
    state<=s0;
end
else begin 
    state<=nstate;
end
end

//combinational next state and output logic

always@(*)begin
    nstate=s0;
    dout=1'b0;
    case(state)
    
    s0: begin
        if(din==1'b1) begin
            nstate=s1;
            dout=1'b0; end
        else begin
            nstate=s0; 
            dout=1'b0; end
    end 
    s1: begin
        if(din==1'b1) begin
            nstate=s2; 
            dout=1'b0; end
        else begin
            nstate=s0;
            dout=1'b0;end
    end
    s2: begin
        if(din==1'b0) begin
            nstate=s3;
            dout=1'b0;end
        else begin
            nstate=s2;
            dout=1'b0; end
    end
    s3: begin
        if(din==1'b1)begin
            nstate=s1;
            dout=1'b1; end
        else begin
            nstate=s0;
            dout=1'b0; end

    end
    default: nstate=s0; dout=1'b0;
    endcase
end 

end

endmodule
