`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////


module tb_register_file();
//port declaration
reg clk, we;
reg [2:0] write_addr,
reg [2:0] read_addr,
reg [7:0] write_data,

wire [7:0] read_data;
reg [7:0] expected_data;

//module instantiation
register_file dut(.clk(clk), .we(we),.write_addr(write_addr),.read_addr(read_addr),.write_data(data),.read_data(read_data));

// initializing values
initial begin
clk = 0;
we = 0;
write_addr=0;
read_addr=0;
read_data = 0;  
end

#10;
// testing values and logic 
always #5 clk=~clk;
write_addr = 3'b010;
write_data = 8'b10101010;
expected_data = 8'b10101010;
we = 1;

#5;
read_addr = 3'b010;
if(read_data!==expected_data) begin
    $display("FAIL: Expected data=%b, Data read=%b",read_data, expected_data);
end

else 
    $display("PASS: Expected data=%b, Data read=%b",read_data, expected_data);


endmodule
