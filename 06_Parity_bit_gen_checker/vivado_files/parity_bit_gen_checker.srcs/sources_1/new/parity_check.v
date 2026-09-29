`timescale 1ns/1ps

module parity_check(
    input [7:0]rx_data, 
    input rx_parity,
    output syndrome );

assign syndrome = ^rx_data^rx_parity;

endmodule