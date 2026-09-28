/*
WRITE                          READ
-----                          ----
needs clock edge               no clock needed
needs WE                       uses read address
changes stored state           only observes stored state

*/
`timescale 1ns / 1ps

module register_file (
    input        clk,
    input        we,
    input  [2:0] write_addr,
    input  [2:0] read_addr,
    input  [7:0] write_data,
    output [7:0] read_data
);

reg [7:0] regs [0:7];

always @(posedge clk) begin
    if (we)
        regs[write_addr] <= write_data;
end

assign read_data = regs[read_addr];

endmodule