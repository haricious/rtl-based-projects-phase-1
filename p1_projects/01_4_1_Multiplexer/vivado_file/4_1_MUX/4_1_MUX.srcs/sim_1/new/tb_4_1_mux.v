`timescale 1ns / 1ps

module tb_4_1_mux();

reg n0, n1, n2,n3;
reg s0, s1;
wire y;

mux4_4x1 dut (n0,n1,n2,n3,s0,s1,y);

initial begin

n0=0;
n1=0;
n2=0;
n3=0;

s0=0;
s1=0;
#5;

n0=0;
n1=1;
n2=0;
n3=1;
s0=0;
s1=1;


#5;
n0=1;
n1=0;
n2=1;
n3=0;
s0=1;
s1=0;

#5;
n0=1;
n1=1;
n2=1;
n3=0;
s0=1;
s1=1;

$finish

if (y !== 0)
    $display("FAIL: expected 0, got %b", y);
else
    $display("PASS");


end

endmodule
