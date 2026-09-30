`timescale 1ns / 1ps

module mealy_seq(
    input  din,
    input  clk,
    input  rst,
    output reg dout
);

    reg [2:0] state, nstate;

    parameter s0 = 3'b000;
    parameter s1 = 3'b001;
    parameter s2 = 3'b010;
    parameter s3 = 3'b011;

    // Sequential state register
    always @(posedge clk) begin
        if (rst)
            state <= s0;
        else
            state <= nstate;
    end

    // Combinational next-state + Mealy output
    always @(*) begin

        nstate = s0;
        dout   = 1'b0;

        case (state)

            // Nothing matched
            s0: begin
                if (din) begin
                    nstate = s1;
                    dout   = 1'b0;
                end
                else begin
                    nstate = s0;
                    dout   = 1'b0;
                end
            end

            // "1" matched
            s1: begin
                if (din) begin
                    nstate = s2;
                    dout   = 1'b0;
                end
                else begin
                    nstate = s0;
                    dout   = 1'b0;
                end
            end

            // "11" matched
            s2: begin
                if (!din) begin
                    nstate = s3;
                    dout   = 1'b0;
                end
                else begin
                    nstate = s2;
                    dout   = 1'b0;
                end
            end

            // "110" matched
            s3: begin
                if (din) begin
                    // 1101 detected
                    // final 1 can start next sequence
                    nstate = s1;
                    dout   = 1'b1;
                end
                else begin
                    nstate = s0;
                    dout   = 1'b0;
                end
            end

            default: begin
                nstate = s0;
                dout   = 1'b0;
            end

        endcase
    end

endmodule