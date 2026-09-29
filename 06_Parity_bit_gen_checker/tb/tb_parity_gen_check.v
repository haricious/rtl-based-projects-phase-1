`timescale 1ns / 1ps

module tb_parity_gen();

reg [7:0] error_mask;
reg [7:0] data;
wire [7:0] tx_data;
wire tx_parity;
wire rx_data;
wire rx parity;
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
tx_data=8'b0000000;
rx_data=0;
tx_parity=0;
rx_parity=0;
syndrome=0;

#10;
data=8'b10101100;
error_mask=8'b00000000;
tx_data=data;
tx_parity=0;
rx_data=tx_data;
rx_parity=0;
syndrome=0;

#10;



$finish;


end

endmodule
