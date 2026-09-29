`timescale 1ns / 1ps

module tb_register_file();

    // port declaration
    reg rst, clk, we;
    reg  [2:0] write_addr;
    reg  [2:0] read_addr;
    reg  [7:0] write_data;

    wire [7:0] read_data;
    reg  [7:0] expected_regs [0:7];
    reg [2:0] read_order [0:7];
    integer i;
    integer seed;

    // clock generation
    always #5 clk = ~clk;

    // module instantiation
    register_file dut (
        .rst(rst),
        .clk(clk),
        .we(we),
        .write_addr (write_addr),
        .read_addr  (read_addr),
        .write_data (write_data),
        .read_data  (read_data)
    );

    // test stimulus
    initial begin

        // initializing values
        clk= 0;
        we= 0;
        write_addr = 0;
        read_addr = 0;
        write_data = 0;
        rst=0;
        seed=$time;
        read_order[0] = 3'd5;
        read_order[1] = 3'd2;
        read_order[2] = 3'd7;
        read_order[3] = 3'd0;
        read_order[4] = 3'd4;
        read_order[5] = 3'd1;
        read_order[6] = 3'd6;
        read_order[7] = 3'd3;

        #10;
    #1;
    for(i=0;i<8;i=i+1) begin
        // synch write
        rst=1'b0;
        we=1'b1;
        write_addr = i;
        write_data = $random(seed) & 8'hFF;
        @(posedge clk);
        #1;
        we=1'b0;

        // asynch read
        read_addr=read_order[i];
        expected_regs[i]=write_data;
        #1;
        if (read_data !== expected_regs[read_addr]) begin
        $display("R%d: FAIL: Expected data=%b, Data read=%b", i,expected_regs[i], read_data);
        end
        else begin
        $display("R%d: PASS: Expected data=%b, Data read=%b", i,expected_regs[i], read_data);
        end

    end


    $finish;
    end 

endmodule