`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module dff(
    input din, clk,
    output q, qn
    );
    
    always@(posedge clk) begin
        q <= din;
        qn <= ~din;
    end

endmodule