`timescale 1ns / 1ps

// 4x1 Multiplexer using behavioural modelling using case
module tb_4_1_mux();

reg [3:0] n;
reg [1:0] sel;
wire y;

mux_4x1 dut(n, sel, y);

initial begin

    n = $random;
    sel = 2'b00;

    #10
    n = $random;
    sel = 2'b01;

    #10;
    n = $random;
    sel = 2'b10;

    #10;
    n = $random;
    sel = 2'b11;

    #10;
    $finish;

end

endmodule
