`timescale 1ns / 1ps

// testcase 1 for decoder circuit with self-testing logic

module tb_3x8decoder();

// port declaration
reg [2:0]x;
reg [7:0]expected;
wire [7:0]y;
integer i;
// module instantiation
decoder3x8 dut(x,y);

// testing values and logic
initial begin

for(i=0; i<8;i=i+1) begin
x=i; #5;
expected = 8'b00000001 << x;
if(y!==expected)
    $display("FAILED: actual value of Y=%b, expected value of Y =%b, since X=%b", y,expected,x);
else
    $display("PASSED: actual value of Y=%b, expected value of Y =%b, since X=%b", y,expected,x);

end
$finish;

end

endmodule