`timescale 1ns / 1ps

module mux_4x1(
    input [3:0]n,
    input [1:0]sel,
    output reg y
);

always @(*) begin
    case(sel) 

        2'b00: y = n[0];
        2'b01: y = n[1];
        2'b10: y = n[2];
        2'b11: y = n[3];
    default: y = 1'b0;
    endcase

end

    

endmodule