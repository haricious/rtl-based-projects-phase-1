`timescale 1ns / 1ps
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