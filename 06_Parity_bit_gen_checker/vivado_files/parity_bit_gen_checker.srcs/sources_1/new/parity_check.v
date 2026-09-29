`timescale 1ns/ps
module parity_check(
    input [7:0]rx_data, rx_parity,
    output syndrome
);

assign syndrome = ^rx_data^rx_parity;


endmodule