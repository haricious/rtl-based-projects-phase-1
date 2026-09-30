`timescale 1ns / 1ps

module tb_seq_det();

    // DUT inputs
    reg din;
    reg clk;
    reg rst;

    // DUT output
    wire dout;

    // Expected output
    reg expected;

    // DUT instantiation
    mealy_seq dut(
        .din(din),
        .clk(clk),
        .rst(rst),
        .dout(dout)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Test logic
    initial begin

        clk      = 0;
        din      = 0;
        rst      = 1;
        expected = 0;

        // -------------------------
        // RESET
        // -------------------------
        @(posedge clk);
        #1;

        if (dout !== expected)
            $display("FAIL: RESET | dout=%b expected=%b",
                     dout, expected);
        else
            $display("PASS: RESET | dout=%b", dout);

        rst = 0;

        // -------------------------
        // 1101
        // -------------------------

        // bit 1
        din      = 1;
        expected = 0;
        @(posedge clk);
        #1;

        if (dout !== expected)
            $display("FAIL: din=%b | dout=%b expected=%b",
                     din, dout, expected);
        else
            $display("PASS: din=%b | dout=%b expected=%b",
                     din, dout, expected);

        // bit 1
        din      = 1;
        expected = 0;
        @(posedge clk);
        #1;

        if (dout !== expected)
            $display("FAIL: din=%b | dout=%b expected=%b",
                     din, dout, expected);
        else
            $display("PASS: din=%b | dout=%b expected=%b",
                     din, dout, expected);

        // bit 0
        din      = 0;
        expected = 0;
        @(posedge clk);
        #1;

        if (dout !== expected)
            $display("FAIL: din=%b | dout=%b expected=%b",
                     din, dout, expected);
        else
            $display("PASS: din=%b | dout=%b expected=%b",
                     din, dout, expected);

        // bit 1 → DETECT
        din      = 1;
        expected = 1;
        @(posedge clk);
        #1;

        if (dout !== expected)
            $display("FAIL: din=%b | dout=%b expected=%b",
                     din, dout, expected);
        else
            $display("PASS: din=%b | dout=%b expected=%b",
                     din, dout, expected);

        $finish;

    end

endmodule