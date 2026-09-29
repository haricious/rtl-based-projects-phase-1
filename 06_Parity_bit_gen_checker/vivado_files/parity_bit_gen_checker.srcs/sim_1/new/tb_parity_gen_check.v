`timescale 1ns / 1ps

module tb_parity_gen_check();

reg [7:0] error_mask;
reg [7:0] data;
wire [7:0] tx_data;
wire tx_parity;
wire [7:0]rx_data;
wire rx_parity;
wire syndrome;


parity_gen_check dut(
    .data(data),
    .error_mask(error_mask),
    .tx_data(tx_data),
    .tx_parity(tx_parity),
    .rx_data(rx_data),
    .rx_parity(rx_parity),
    .syndrome(syndrome)
);

initial begin
#10;
data=8'b00000000;
error_mask=8'b00000000;

#10;
data=8'b10101100;
error_mask=8'b00000000;

#1;
$display("data=%08b",data);
$display("error_mask=%08b",error_mask);
$display("tx_data=%08b, tx_parity=%08b", tx_data, tx_parity);
$display("rx_data=%08b, rx_parity=%08b, syndrome=%0b", rx_data, rx_parity,syndrome);

#10;



$finish;


end

endmodule
