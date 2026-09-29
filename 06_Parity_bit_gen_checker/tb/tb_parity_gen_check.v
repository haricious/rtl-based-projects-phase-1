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

module tb_parity_check();

wire rx_data;
wire rx_parity;

reg syndrome;

integer i;

parity_check dut(.rx_data(rx_data), .rx_parity(rx_parity), .syndrome(syndrome));

initial begin



end

endmodule