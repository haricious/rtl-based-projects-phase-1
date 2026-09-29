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
    // writing R0
    rst=1'b0;
    we=1'b1;
    write_addr = 3'b000;
    write_data=$random & 8'hFF;

    @(posedge clk);
    #1;
    read_addr = 3'b000;
    expected_data=write_data;
    #1;
    if (read_data !== expected_data) begin
        $display("R0: FAIL: Expected data=%b, Data read=%b",
                 expected_data, read_data);
    end
    else begin
        $display("R0: PASS: Expected data=%b, Data read=%b",
                 expected_data, read_data);
    end

    //writing R1
    rst=1'b0;
    we=1'b1;
    write_addr = 3'b001
    write_data=$random & 8'hFF;
    
    @(posedge clk);
    read_addr = 3'b001;
    expected_data=write_data;
    #1;
    if (read_data !== expected_data) begin
        $display("R1: FAIL: Expected data=%b, Data read=%b",
                 expected_data, read_data);
    end
    else begin
        $display("R1: PASS: Expected data=%b, Data read=%b",
                 expected_data, read_data);
    end
    #1;
    // writing R2
    rst=1'b0;
    we = 1'b1;
    write_addr = 3'b010;
    write_data = 8'b00001111;
    
    @(posedge clk);
    #1;
    read_addr = 3'b010;
    expected_data = 8'b00001111;
    #1;
    if (read_data !== expected_data) begin
        $display("FAIL: Expected data=%b, Data read=%b",
                 expected_data, read_data);
    end
    else begin
        $display("PASS: Expected data=%b, Data read=%b",
                 expected_data, read_data);
    end
    //writing R3

    // writing R4

    //writing R5
    rst=1'b0;
    we = 1'b1;
    write_addr = 3'b101;
    write_data = 8'b10100101;
    @(posedge clk);
    #1;
    read_addr = 3'b101;
    expected_data = 8'b10100101;
    #1;
    if (read_data !== expected_data) begin
        $display("FAIL: Expected data=%b, Data read=%b",
                 expected_data, read_data);
    end
    else begin
        $display("PASS: Expected data=%b, Data read=%b",
                 expected_data, read_data);
    end
    #1;

    // Writing R6

    // Writing R7
    
    
            $finish;
        end 

endmodule