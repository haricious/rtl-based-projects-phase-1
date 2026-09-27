`timescale 1ns / 1ps

// testbench code for stress-test

module tb_mux4x1();

    reg [3:0] n;
    reg [1:0] sel;
    wire y;

    integer pass_count;
    integer fail_count;

    mux_4x1 dut(
        n[0],
        n[1],
        n[2],
        n[3],
        sel[0],
        sel[1],
        y
    );

    initial begin

        pass_count = 0;
        fail_count = 0;

        // test vector
        n = 4'b0000;
        sel = 2'b00;
        #5;
        if (y !== n[sel]) begin
            $display("FAIL: n=%b sel=%b expected=%b got=%b",
                     n, sel, n[sel], y);
            fail_count = fail_count + 1;
        end
        else begin
            $display("PASS: n=%b sel=%b y=%b", n, sel, y);
            pass_count = pass_count + 1;
        end

        n = 4'b0001;
        sel = 2'b01;
        #5;
        if (y !== n[sel]) begin
            $display("FAIL: n=%b sel=%b expected=%b got=%b",
                     n, sel, n[sel], y);
            fail_count = fail_count + 1;
        end
        else begin
            $display("PASS: n=%b sel=%b y=%b", n, sel, y);
            pass_count = pass_count + 1;
        end

        n = 4'b0010;
        sel = 2'b10;
        #5;
        if (y !== n[sel]) begin
            $display("FAIL: n=%b sel=%b expected=%b got=%b",
                     n, sel, n[sel], y);
            fail_count = fail_count + 1;
        end
        else begin
            $display("PASS: n=%b sel=%b y=%b", n, sel, y);
            pass_count = pass_count + 1;
        end

        n = 4'b0011;
        sel = 2'b11;
        #5;
        if (y !== n[sel]) begin
            $display("FAIL: n=%b sel=%b expected=%b got=%b",
                     n, sel, n[sel], y);
            fail_count = fail_count + 1;
        end
        else begin
            $display("PASS: n=%b sel=%b y=%b", n, sel, y);
            pass_count = pass_count + 1;
        end

        n = 4'b0100;
        sel = 2'b00;
        #5;
        if (y !== n[sel]) begin
            $display("FAIL: n=%b sel=%b expected=%b got=%b",
                     n, sel, n[sel], y);
            fail_count = fail_count + 1;
        end
        else begin
            $display("PASS: n=%b sel=%b y=%b", n, sel, y);
            pass_count = pass_count + 1;
        end

        n = 4'b0101;
        sel = 2'b01;
        #5;
        if (y !== n[sel]) begin
            $display("FAIL: n=%b sel=%b expected=%b got=%b",
                     n, sel, n[sel], y);
            fail_count = fail_count + 1;
        end
        else begin
            $display("PASS: n=%b sel=%b y=%b", n, sel, y);
            pass_count = pass_count + 1;
        end

        n = 4'b0110;
        sel = 2'b10;
        #5;
        if (y !== n[sel]) begin
            $display("FAIL: n=%b sel=%b expected=%b got=%b",
                     n, sel, n[sel], y);
            fail_count = fail_count + 1;
        end
        else begin
            $display("PASS: n=%b sel=%b y=%b", n, sel, y);
   
            fail_count = fail_count + 1;
        end
        else begin
            $display("PASS: n=%b sel=%b y=%b", n, sel, y);
            pass_count = pass_count + 1;
        end

        n = 4'b1000;
        sel = 2'b00;
        #5;
        if (y !== n[sel]) begin
            $display("FAIL: n=%b sel=%b expected=%b got=%b",
                     n, sel, n[sel], y);
            fail_count = fail_count + 1;
        end
        else begin
            $display("PASS: n=%b sel=%b y=%b", n, sel, y);
            pass_count = pass_count + 1;
        end

        n = 4'b1001;
        sel = 2'b01;
        #5;
        if (y !== n[sel]) begin
            $display("FAIL: n=%b sel=%b expected=%b got=%b",
                     n, sel, n[sel], y);
            fail_count = fail_count + 1;
        end
        else begin
            $display("PASS: n=%b sel=%b y=%b", n, sel, y);
            pass_count = pass_count + 1;
        end

        n = 4'b1010;
        sel = 2'b10;
        #5;
        if (y !== n[sel]) begin
            $display("FAIL: n=%b sel=%b expected=%b got=%b",
                     n, sel, n[sel], y);
            fail_count = fail_count + 1;
        end
        else begin
            $display("PASS: n=%b sel=%b y=%b", n, sel, y);
            pass_count = pass_count + 1;
        end

        n = 4'b1100;
        sel = 2'b11;
        #5;
        if (y !== n[sel]) begin
            $display("FAIL: n=%b sel=%b expected=%b got=%b",
                     n, sel, n[sel], y);
            fail_count = fail_count + 1;
        end
        else begin
            $display("PASS: n=%b sel=%b y=%b", n, sel, y);
            pass_count = pass_count + 1;
        end

        n = 4'b1101;
        sel = 2'b00;
        #5;
        if (y !== n[sel]) begin
            $display("FAIL: n=%b sel=%b expected=%b got=%b",
                     n, sel, n[sel], y);
            fail_count = fail_count + 1;
        end
        else begin
            $display("PASS: n=%b sel=%b y=%b", n, sel, y);
            pass_count = pass_count + 1;
        end

        n = 4'b1111;
        sel = 2'b10;
        #5;
        if (y !== n[sel]) begin
            $display("FAIL: n=%b sel=%b expected=%b got=%b",
                     n, sel, n[sel], y);
            fail_count = fail_count + 1;
        end
        else begin
            $display("PASS: n=%b sel=%b y=%b", n, sel, y);
            pass_count = pass_count + 1;
        end

        $display("PASS: %0d", pass_count);
        $display("FAIL: %0d", fail_count);
     

        $finish;
    end

endmodule