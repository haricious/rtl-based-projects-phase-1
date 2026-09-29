
`timescale 1ns / 1ps

module register_file (
    input clk,rst,
    input we,
    input  [2:0] write_addr,
    input  [2:0] read_addr,
    input  [7:0] write_data,
    output [7:0] read_data
);
integer i;
reg [7:0] regs [0:7];

always @(posedge clk) begin
    if (rst)
        for(i=0;i<8;i=i+1) 
            regs[i]<=8'b0;
    else if (we)
        regs[write_addr] <= write_data;
end

assign read_data = regs[read_addr];

endmodule