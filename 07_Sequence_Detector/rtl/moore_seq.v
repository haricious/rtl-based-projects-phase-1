module moore_seq(
    input din,
    input clk, rst,
    output reg dout
);

reg [1:0]state;

// state declaration

parameter s0 =2'b00;
parameter s1=2'b01;
parameter s2=2'b10
parameter s3=2'b11;

// reset logic
always@(posedge clk) begin
if(rst!==1'b0) begin
    state<=s0;
end

else
    state<=nstate;
end

// next state logic + output logic

always@(posedge clk) begin

case(state)

s0: begin
    if(din==0) begin
        state <= s0;
        dout <=1'b0;
    end
    else begin
        state<=s1;
        dout<=1'b0;
    end
end
s1: begin
    if(din==0) begin
        state <= s2;
        dout <=1'b0;
    end
    else begin
        state<=s1;
        dout<=1'b0;
    end
end
s2: begin
    if(din==0) begin
        state <= s2;
        dout <=1'b0;
    end
    else begin
        state<=s3;
        dout<=1'b0;
    end
end
s3: begin
    if(din==0) begin
        state <= s2;
        dout <=1'b0;
    end
    else begin
        state<=s1;
        dout<=1'b1;
    end
end
default: begin state=s0; dout=1'b0; end
endcase

end

endmodule