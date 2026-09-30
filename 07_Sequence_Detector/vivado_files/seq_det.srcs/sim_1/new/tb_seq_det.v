`timescale 1ns / 1ps

module tb_mealy_seq;

    reg din;
    reg clk;
    reg rst;

    wire dout;

    reg expected;

    mealy_seq dut (
        .din  (din),
        .clk  (clk),
        .rst  (rst),
        .dout (dout)
    );

    // 10 ns clock
    always #5 clk = ~clk;

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
            $display("PASS: RESET | dout=%b",
                     dout);

        rst = 0;

        // -------------------------
        // 1101
        // -------------------------

        // bit 1
        @(negedge clk);
        din      = 1;
        expected = 0;

        @(posedge clk);
        #1;

        if (dout !== expected)
            $display("FAIL: 1 | dout=%b expected=%b",
                     dout, expected);
        else
            $display("PASS: 1 | dout=%b",
                     dout);


        // bit 1
        @(negedge clk);
        din      = 1;
        expected = 0;

        @(posedge clk);
        #1;

        if (dout !== expected)
            $display("FAIL: 11 | dout=%b expected=%b",
                     dout, expected);
        else
            $display("PASS: 11 | dout=%b",
                     dout);


        // bit 0
        @(negedge clk);
        din      = 0;
        expected = 0;

        @(posedge clk);
        #1;

        if (dout !== expected)
            $display("FAIL: 110 | dout=%b expected=%b",
                     dout, expected);
        else
            $display("PASS: 110 | dout=%b",
                     dout);


        // bit 1 → DETECT
        @(negedge clk);
        din      = 1;
        expected = 1;

        @(posedge clk);
        #1;

        if (dout !== expected)
            $display("FAIL: 1101 | dout=%b expected=%b",
                     dout, expected);
        else
            $display("PASS: 1101 | dout=%b",
                     dout);


        $finish;

    end

endmodule