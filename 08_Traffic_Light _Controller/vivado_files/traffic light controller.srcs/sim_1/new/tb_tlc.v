`timescale 1ns / 1ps


module tb_tlc();

// ports declaration
reg clk;
reg rst;

wire A_red;
wire A_yellow;
wire A_green;

wire B_red;
wire B_yellow;
wire B_green;

reg expected_lit;


// module instantiation

tlc dut(
    .clk(clk),
    .rst(rst),
    .A_red(A_red),
    .A_yellow(A_yellow),
    .A_green(A_green),
    .B_red(B_red),
    .B_yellow(B_yellow),
    .B_green(B_green)
);

// clock generation
always #500000000 clk=~clk;


//asserting initial values
initial  begin 
clk=0;
rst=1;

@(posedge clk);
@(negedge clk);
rst=0;

repeat(10)
    @(posedge clk);
rst=0;

repeat(3)
    @(posedge clk);
rst=0;

@(negedge clk);

if (A_red === 1'b0 &&
    A_yellow === 1'b0 &&
    A_green === 1'b1 &&
    B_red === 1'b1 &&
    B_yellow === 1'b0 &&
    B_green === 1'b0)
    $display("S0 PASS");
else $display("S0 FAIL");

if (A_red === 1'b0 &&
    A_yellow === 1'b1 &&
    A_green === 1'b0 &&
    B_red === 1'b1 &&
    B_yellow === 1'b0 &&
    B_green === 1'b0)
    $display("S1 PASS");
else $display("S1 FAIL");

if (A_red === 1'b1 &&
    A_yellow === 1'b0 &&
    A_green === 1'b0 &&
    B_red === 1'b0 &&
    B_yellow === 1'b0 &&
    B_green === 1'b1)
    $display("S2 PASS");
else $display("S2 FAIL");

if (A_red === 1'b1 &&
    A_yellow === 1'b0 &&
    A_green === 1'b0 &&
    B_red === 1'b0 &&
    B_yellow === 1'b1 &&
    B_green === 1'b0)
    $display("S3 PASS");
else $display("S3 FAIL");

$finish;


end


endmodule