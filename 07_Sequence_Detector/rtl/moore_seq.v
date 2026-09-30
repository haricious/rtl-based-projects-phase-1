module moore_seq(
    input din,
    input clk, rst,
    output reg dout
);

reg [2:0] state, nstate;

// state declaration

parameter s0=3'b000;
parameter s1=3'b001;
parameter s2=3'b010;
parameter s3=3'b011;
parameter s4=3'b100;


// seq reset logic
always@(posedge clk) begin
if(rst)
    state<=s0;
else
    state<=nstate;
end

// combinational output logic
always@(*)begin
case(state)
s0: dout=0;
s1: dout=0;
s2: dout=0;
s3: dout=0;
s4: dout=1;


default: dout=1'b0;
endcase
end

// combinational next state logic

always@(*) begin 
nstate=idle;
case(state)
s0:begin
    if(din==1'b0)
        nstate=s0;
    else
        nstate=s1;
end 
s1:begin
    if(din==1'b0)
        nstate=s2;
    else
        nstate=s1;
end
s2:begin
    if(din==1'b0)
        nstate=s2;
    else
        nstate=s3;
end
s3:begin
    if(din==1'b0)
        nstate=s2;
    else
        nstate=s4;
end
s4:begin
    if(din==1'b0)
        nstate=s2;
    else
        nstate=s1;
end

default: nstate=3'b000;
endcase


end


endmodule