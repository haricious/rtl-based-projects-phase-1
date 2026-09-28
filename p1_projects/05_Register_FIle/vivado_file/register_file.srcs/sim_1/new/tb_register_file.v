`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////


module tb_register_file();
//port declaration
reg clk, we;
reg [2:0] write_addr;
reg [2:0] read_addr;
reg [7:0] write_data;

wire [7:0] read_data;
reg [7:0] expected_data;

//clock generation 
always #5 clk = ~clk;

//module instantiation
register_file dut(.clk(clk), .we(we),.write_addr(write_addr),.read_addr(read_addr),.write_data(write_data),.read_data(read_data));

// initializing values

initial begin
clk = 0;
we = 0;
write_addr=0;
read_addr=0;

#10;
// testing values and logic 
write_addr = 3'b010;
write_data = 8'b10101010;
expected_data = 8'b10101010;
we = 1;

@(posedge clk);
#1;

$display("DEBUG: we=%b write_addr=%b write_data=%b R2=%b",
         we, write_addr, write_data, dut.regs[2]);

read_addr = 3'b010;
#1;

$display("DEBUG: read_addr=%b read_data=%b",
         read_addr, read_data);
$finish;
end


endmodule
