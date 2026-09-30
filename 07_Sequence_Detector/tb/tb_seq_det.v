`timescale 1ns /1ps


module tb_seq_det();

//port declaration

reg din;
reg clk;
reg rst;
wire dout;


//module instantiation

moore_seq dut(
    .din(.din),
    .clk(.clk),
    .rst(.rst),
    .dout(dout)
);

// clock generation
always #5 clk = ~clk;

// testing logic

initial begin
clk=0;
din=0;
rst=0;

#10;





$finish;
end

endmodule