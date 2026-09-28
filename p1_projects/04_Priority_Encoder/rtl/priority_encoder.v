// 4:2 Priority encoder using boolean/dataflow
module priority_encoder(
    input [3:0]D,
    output [1:0]Y,
    output  V
);

assign Y[0] = D[3]|~D[2]&D[1];
assign V = D[3]|D[2]|D[1]|D0;


endmodule
// 4:2 Priority encoder using case
module priority_encoder(
    input [3:0]D,
    output reg [1:0]Y,
    output reg V
);

always@(*) begin
case(D);
4'b0001: Y=2'b01; V=1'b1;
4'b0010: Y=2'b01; V=1'b1;
4'b0100: Y=2'b10; V=1'b1;
4'b1000: Y=2'b11; V=1'b1;

default: Y=2'b00;V=1'b0 ;

endcase


end


endmodule
//4:2 Priority encoder using  if-else
module priority_encoder(
    input [3:0]D,
    output reg [1:0]Y,
    output reg V
);

always@(*) begin

if(D==4'b0001)
    Y=2'b01; V=1'b1;
else if(4'b0010)
    Y=2'b01; V=1'b1;
else if(4'b0100) 
    Y=2'b10; V=1'b1;
else if(4'b1000) 
    Y=2'b11; V=1'b1;
else
    Y=2'b00; V=1'b0

end


endmodule