`timescale 1ns / 1ps

module parity_gen_check(
    input  [7:0] error_mask,
    input  [7:0] data,

    output [7:0] tx_data,
    output       tx_parity,

    output [7:0] rx_data,
    output       rx_parity,
    output       syndrome
);

    assign tx_data  = data;
    assign rx_data  = tx_data ^ error_mask;
    assign rx_parity = tx_parity;

    parity_gen gen(
        .data(data),
        .parity_bit(tx_parity)
    );

    parity_check check(
        .rx_data(rx_data),
        .rx_parity(rx_parity),
        .syndrome(syndrome)
    );

endmodule