// testcase to check 8bit parity generator
`timescale 1ns / 1ps

module tb_parity_gen();

    reg  [7:0] data;
    wire       parity_bit;
    reg        expected_parity;
    integer    i;

    parity_gen dut (
        .data(data),
        .parity_bit(parity_bit)
    );

    initial begin

        #10;

        for (i = 0; i < 256; i = i + 1) begin

            data = i;
            expected_parity = ^data;

            #1;

            if (parity_bit !== expected_parity) begin
                $display(
                    "FAIL: Data=%08b, actual parity=%b, expected parity=%b",
                    data, parity_bit, expected_parity
                );
            end
            else begin
                $display(
                    "PASS: Data=%08b, actual parity=%b, expected parity=%b",
                    data, parity_bit, expected_parity
                );
            end

        end

        $finish;
    end

endmodule



`timescale 1ns / 1ps

module parity_check(
    input  [7:0] rx_data,
    input        rx_parity,
    output       syndrome
);

    assign syndrome = ^rx_data ^ rx_parity;

endmodule


// testcase to check 8-bit parity checker
module tb_parity_check();

    reg  [7:0] rx_data;
    reg        rx_parity;
    wire       syndrome;

    reg        expected_syndrome;

    integer i;

    parity_check dut (
        .rx_data(rx_data),
        .rx_parity(rx_parity),
        .syndrome(syndrome)
    );

    initial begin

        #10;

        for(i = 0; i < 512; i = i + 1) begin

            rx_data   = i;
            rx_parity = i[8];

            expected_syndrome = ^rx_data ^ rx_parity;

            #1;

            if(syndrome !== expected_syndrome) begin
                $display(
                    "FAIL: rx_data=%08b, rx_parity=%b, actual syndrome=%b, expected syndrome=%b",
                    rx_data, rx_parity, syndrome, expected_syndrome
                );
            end
            else begin
                $display(
                    "PASS: rx_data=%08b, rx_parity=%b, syndrome=%b",
                    rx_data, rx_parity, syndrome
                );
            end

        end

        $finish;
    end

endmodule