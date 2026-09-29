// testcase to check 8bit parity generator
`timescale 1ns /1ps
module tb_parity_gen_check();

reg [7:0]data;
wire parity_bit;
integer i;
reg expected_parity;

parity_gen dut (.data(data),.parity_bit(parity_bit));

initial begin
#10;
for(i=0;i<256;i=i+1) begin 
    data=i;
    #1;
    expected_parity = ^data;
    if(parity_bit!==expected_parity)
        $display("FAIL: Data=%0b, acctual parity_bit=%0b, expected parity=%0b",data,parity_bit,expected_parity);
    else
        $display("PASS: Data=%0b, acctual parity_bit=%0b, expected parity=%0b",data,parity_bit,expected_parity);
end

$finish;


endmodule