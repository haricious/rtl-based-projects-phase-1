`timescale 1ns /1ps


module tb_seq_det();

//port declaration

reg din;
reg clk;
reg rst;
wire dout;

reg expected;


//module instantiation

moore_seq dut(
    .din(din),
    .clk(clk),
    .rst(rst),
    .dout(dout)
);

// clock generation
always #5 clk = ~clk;

// testing logic

initial begin
clk=0;
din=0;
rst=1;
expected=0;
#10;

@(posedge clk);
#1;
if(dout!==expected)
    $display("FAIL: reset : dout=%b, expected=%b",dout, expected);
else
    $display("PASS: reset: dout=%b", dout);

rst=0;

din=1;
expected=0;
@(posedge clk)
#1;
if(dout!==expected)
    $display("FAIL: din=%b, dout=%b, expected=%b", din, dout, expected);
else
    $display("FAIL: din=%b, dout=%b, expected=%b", din, dout, expected);

din=0;
expected=0;
@(posedge clk)
#1;
if(dout!==expected)
    $display("FAIL: din=%b, dout=%b, expected=%b", din, dout, expected);
else
    $display("PASS: din=%b, dout=%b, expected=%b", din, dout, expected);

din=1;
expected=0;
@(posedge clk)
#1;
if(dout!==expected)
    $display("FAIL: din=%b, dout=%b, expected=%b", din, dout, expected);
else
    $display("PASS: din=%b, dout=%b, expected=%b", din, dout, expected);

din=1;
expected=0;
@(posedge clk)
#1;
if(dout!==expected)
    $display("FAIL: din=%b, dout=%b, expected=%b", din, dout, expected);
else
    $display("PASS: din=%b, dout=%b, expected=%b", din, dout, expected);


$finish;
end

endmodule