module moore_seq(
    input din,
    input clk, rst,
    output reg dout
);

reg [3:0]state;

// state declaration

parameter s0=4'b000;
parameter s1=4'b001;
parameter s2=4'b010;
parameter s3=4'b011;
parameter s4=4'b100;


// reset logic

   

// next state logic + output logic

always@(posedge clk) begin

case(state)

s0: begin
    
end
s1: begin
    
end
s2: begin
    
end
s3: begin
   
end
default: begin  end
endcase

end

endmodule