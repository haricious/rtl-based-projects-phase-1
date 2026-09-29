`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module tb_register_file();

    // port declaration
    reg rst, clk, we;
    reg  [2:0] write_addr;
    reg  [2:0] read_addr;
    reg  [7:0] write_data;

    wire [7:0] read_data;
    reg  [7:0] expected_data;
    integer i;

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
        expected_data = 0;
        rst=0;

        #10;
    #1;
    for(i=0;i<8;i=i+1) begin
        write_addr = i;
        write_data = $random & 8'hFF;
        @(posedge clk);
        #1;
        read_data=i;
        expected_data=write_data;
        #1;
        if (read_data !== expected_data) begin
        $display("%d: FAIL: Expected data=%b, Data read=%b", write_addr[i],expected_data, read_data);
        end
        else begin
        $display("%d: PASS: Expected data=%b, Data read=%b", write_addr[i],expected_data, read_data);
        end

    end


    $finish;
    end 

endmodule