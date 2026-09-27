`timescale 1ns / 1ps
// testcase for 4x1 mux using structural modelling 

module tv_mux4x1();

reg n0, n1, n2, n3;
reg s0, s1;
wire y;

mux_4x1 dut(n0,n1,n2,n3,s0,s1,y);

inital begin

//test vector
n0= 0;
n1= 1;
n2= 1;
n3= 0;

s1=0; s0=0; #10;
if(y!==n0)
    $display("Failed: 00, y= %b",y);

    else $display("Passed: 00, y=%b",y)
s1=0; s0=1; #10;
if(y!==n1)
    $display("Failed: 00, y= %b",y);

    else $display("Passed: 00, y=%b",y)
s1=1; s0=0; #10;
if(y!==n2)
    $display("Failed: 00, y= %b",y);

    else $display("Passed: 00, y=%b",y)
s1=1; s0=1; #10;
if(y!==n3)
    $display("Failed: 00, y= %b",y);

    else $display("Passed: 00, y=%b",y)


$finish
end


endmodule

