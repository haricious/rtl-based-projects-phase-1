`timescale 1ns / 1ps

//4:2 Priority encoder using  if-else
module priority_encoder(
    input [3:0]D,
    output reg [1:0]Y,
    output reg V
);

always@(*) begin

if(D[3]) Y=2'b11; V=1'b1;
else if (D[2]) Y=2'b10; V=1'b1;
else if (D[1]) Y=2'b01; V=1'b1;
else if (D[0]) Y=2'b00; V=1'b1;

else
    Y=2'b00; V=1'b0;

end

endmodule