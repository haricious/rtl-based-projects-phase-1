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
    write_addr = 3'b001;
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
    write_data = $random & 8'hFF;
    
    @(posedge clk);
    #1;
    read_addr = 3'b010;
    expected_data = write_data;
    #1;
    if (read_data !== expected_data) begin
        $display("R2: FAIL: Expected data=%b, Data read=%b",
                 expected_data, read_data);
    end
    else begin
        $display("R2: PASS: Expected data=%b, Data read=%b",
                 expected_data, read_data);
    end
    //writing R3
    rst=1'b0;
    we=1'b1;
    write_addr = 3'b011;
    write_data = $random & 8'hFF;

    @(posedge clk);
    #1;
    read_addr = 3'b011;
    expected_data = write_data;
    #1;
    if (read_data !== expected_data) begin
        $display("R3: FAIL: Expected data=%b, Data read=%b",
                 expected_data, read_data);
    end
    else begin
        $display("R3: PASS: Expected data=%b, Data read=%b",
                 expected_data, read_data);
    end

    // writing R4
    rst=1'b0;
    we=1'b1;
    write_addr=3'b100;
    write_data=$random & 8'hFF;

    @(posedge clk);
    #1;
    read_addr = 3'b100;
    expected_data = write_data;
    #1;
    if (read_data !== expected_data) begin
        $display("R4: FAIL: Expected data=%b, Data read=%b",
                 expected_data, read_data);
    end
    else begin
        $display("R4: PASS: Expected data=%b, Data read=%b",
                 expected_data, read_data);
    end

    //writing R5
    rst=1'b0;
    we = 1'b1;
    write_addr = 3'b101;
    write_data = $random & 8'hFF;
    @(posedge clk);
    #1;
    read_addr = 3'b101;
    expected_data = write_data;
    #1;
    if (read_data !== expected_data) begin
        $display("R5: FAIL: Expected data=%b, Data read=%b",
                 expected_data, read_data);
    end
    else begin
        $display("R5: PASS: Expected data=%b, Data read=%b",
                 expected_data, read_data);
    end
    #1;

    // Writing R6
    rst=1'b0;
    we = 1'b1;
    write_addr = 3'b110;
    write_data = $random & 8'hFF;
    @(posedge clk);
    #1;
    read_addr = 3'b110;
    expected_data = write_data;
    #1;
    if (read_data !== expected_data) begin
        $display("R6: FAIL: Expected data=%b, Data read=%b",
                 expected_data, read_data);
    end
    else begin
        $display("R6: PASS: Expected data=%b, Data read=%b",
                 expected_data, read_data);
    end

    // Writing R7
    rst=1'b0;
    we = 1'b1;
    write_addr = 3'b111;
    write_data = $random & 8'hFF;
    @(posedge clk);
    #1;
    read_addr = 3'b111;
    expected_data = write_data;
    #1;
    if (read_data !== expected_data) begin
        $display("R7: FAIL: Expected data=%b, Data read=%b",
                 expected_data, read_data);
    end
    else begin
        $display("R7: PASS: Expected data=%b, Data read=%b",
                 expected_data, read_data);
    end

    
    
    $finish;
    end 

endmodule


// testcase for register file using loop

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
        $display("%d: FAIL: Expected data=%b, Data read=%b", write_adrr[i],expected_data, read_data);
        end
        else begin
        $display("%d: PASS: Expected data=%b, Data read=%b", write_adrr[i],expected_data, read_data);
        end

    end


    $finish;
    end 

endmodule