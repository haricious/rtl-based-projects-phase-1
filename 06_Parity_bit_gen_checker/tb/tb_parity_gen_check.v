// testcase to check 8bit parity generator

module tb_parity_gen_check();

reg [7:0]data;
wire parity_bit;
integer i;

parity_gen dut (.data(data),.parity_bit(parity_bit));

initial begin
#10;
for(i=0;i<256;i=i+1) begin 
    data=i;
    $display("Data=%0b, parity_bit=%0b",data,parity_bit);
end

$finish


endmodule