`timescale 1ns / 1ps

module dff(
    input din, clk,
    output reg q, qn
    );
    
    always@(posedge clk) begin

        din <= q;
        qn <= ~q;
    
    
    end

endmodule

module register_file(
    input data_in,clk, 
    output reg dout
    );
    
    ff1 dff(data_in, clk, )
endmodule
