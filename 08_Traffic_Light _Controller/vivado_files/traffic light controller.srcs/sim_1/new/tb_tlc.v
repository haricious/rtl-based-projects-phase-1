`timescale 1ns / 1ps


module tb_tlc();

// ports declaration
reg clk;
reg rst;

wire A_red;
wire A_yellow;
wire A_green;

wire B_red;
wire B_yellow;
wire B_green;

integer i;

// module instantiation

tlc dut(
    .clk(clk),
    .rst(rst),
    .A_red(A_red),
    .A_yellow(A_yellow),
    .A_green(A_green),
    .B_red(B_red),
    .B_yellow(B_yellow),
    .B_green(B_green)
);

// clock generation
always #5 clk=~clk;


//asserting initial values
initial  begin 
clk=0;
rst=1;

@(posedge clk);
@(negedge clk);
rst=0;

for(i=0;i<50;i=i+1) begin
    repeat(10)
    @(posedge clk);
    rst=0;

    repeat(3)
    @(posedge clk);
    rst=0;

    $display("State: %b, nstate: %b", state, nstate);

end


$finish;



end


endmodule