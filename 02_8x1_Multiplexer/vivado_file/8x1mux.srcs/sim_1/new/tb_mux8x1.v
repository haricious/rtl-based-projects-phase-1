`timescale 1ns / 1ps

// testcase for 8x1 mux which was designed using 2- 4x1 mux and 1 - 2x1 mux

module tb_mux8x1();

reg [7:0]n;
reg [2:0]sel;
wire y;


// instantiating the design under test

mux8x1 dut(n,sel,y);

initial begin

n=8'b00001111; sel = 3'b000; #10;
if(y!==n[sel])
    $display("FAIL: y=%b",y);
else
    $display("PASS: y=%b", y);
n=8'b01001111; sel = 3'b001; #10;
if(y!==n[sel])
    $display("FAIL: y=%b",y);
else
    $display("PASS: y=%b", y);
n=8'b01010110; sel = 3'b010; #10;
if(y!==n[sel])
    $display("FAIL: y=%b",y);
else
    $display("PASS: y=%b", y);
n=8'b00001110; sel = 3'b011; #10;
if(y!==n[sel])
    $display("FAIL: y=%b",y);
else
    $display("PASS: y=%b", y);
n=8'b00100111; sel = 3'b100; #10;
if(y!==n[sel])
    $display("FAIL: y=%b",y);
else
    $display("PASS: y=%b", y);
n=8'b10001101; sel = 3'b101; #10;
if(y!==n[sel])
    $display("FAIL: y=%b",y);
else
    $display("PASS: y=%b", y);
n=8'b01001011; sel = 3'b110; #10;
if(y!==n[sel])
    $display("FAIL: y=%b",y);
else
    $display("PASS: y=%b", y);
n=8'b00101011; sel = 3'b111; #10;
if(y!==n[sel])
    $display("FAIL: y=%b",y);
else
    $display("PASS: y=%b", y);


$finish;


end

endmodule