`timescale 1ns / 1ps

// testcase for 8x1 mux which was designed using 2- 4x1 mux and 1 - 2x1 mux

module tb_mux8x1();

reg [7:0]n;
reg [2:0]sel;
wire y;


// instantiating the design under test

mux8x1 dut(n,sel,y);

initial begin

n=8'b00001111; sel = 000; #10;
n=8'b01001111; sel = 001; #10;
n=8'b01010110; sel = 010; #10;
n=8'b00001110; sel = 011; #10;
n=8'b00100111; sel = 100; #10;
n=8'b10001101; sel = 101; #10;
n=8'b01001011; sel = 110; #10;
n=8'b00101011; sel = 111; #10;


$finish;


end

endmodule