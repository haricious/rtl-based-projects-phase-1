`timescale 1ns / 1ps

// 4x1 Multiplexer using behavioural modelling using case
`timescale 1ns/1ps

module tb_4_1_mux;

    reg  [3:0] n;
    reg  [1:0] sel;
    wire       y;

    mux_4x1 dut (
        .n(n),
        .sel(sel),
        .y(y)
    );

    initial begin

        // Test 1
        n = 4'b0001;
        sel = 2'b00;
        #10;
        if (y !== n[0])
            $display("FAIL: sel=%b, expected=%b, got=%b", sel, n[0], y);
        else
            $display("PASS: sel=%b, y=%b", sel, y);

        // Test 2
        n = 4'b0010;
        sel = 2'b01;
        #10;
        if (y !== n[1])
            $display("FAIL: sel=%b, expected=%b, got=%b", sel, n[1], y);
        else
            $display("PASS: sel=%b, y=%b", sel, y);

        // Test 3
        n = 4'b0100;
        sel = 2'b10;
        #10;
        if (y !== n[2])
            $display("FAIL: sel=%b, expected=%b, got=%b", sel, n[2], y);
        else
            $display("PASS: sel=%b, y=%b", sel, y);

        // Test 4
        n = 4'b1000;
        sel = 2'b11;
        #10;
        if (y !== n[3])
            $display("FAIL: sel=%b, expected=%b, got=%b", sel, n[3], y);
        else
            $display("PASS: sel=%b, y=%b", sel, y);

        $finish;
    end

endmodule