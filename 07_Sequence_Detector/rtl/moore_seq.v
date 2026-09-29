module moore_seq(
    input [3:0] din,
    input clk, rst,
    output reg dout
);

reg state, nstate;

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

// next state logic 


// output logic



endmodule