`timescale 1ns/ps
//testcase to check 8bit parity checker
module tb_parity_check();

wire rx_data;
wire rx_parity;
wire expected_parity;

reg syndrome;

integer i;

parity_check dut(.rx_data(rx_data), .rx_parity(rx_parity), .syndrome(syndrome));

initial begin
    #10;
for(i=0;i<256;i=i+1) begin
rx_data=i;
expected_parity=^rx_data^rx_parity;
#1;
if(rx_parity!==expected_parity) begin
    $display("FAIL: rx_data=%08b, actual parity=%b, expected parity=%b", rx_data, syndrome, expected_parity);
end
else 
    $display("PASS: rx_data=%08b, actual parity=%b, expected parity=%b", rx_data, syndrome, expected_parity);
end


$finish;
end

endmodule