`timescale 1ns / 1ps

module tb_tlc();
//port declaration
reg clk, rst;

wire A_red;
wire A_yellow;
wire A_green;

wire B_red;
wire B_yellow;
wire B_green;


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


// testing logic

initial begin
    // initial values
    clk=0;
    rst=0;

    #100; rst=1;
    @(posedge clk);
    @(negedge clk);    
    rst=0;

    repeat(10)
        @(posedge clk);


$finish;
end





endmodule
