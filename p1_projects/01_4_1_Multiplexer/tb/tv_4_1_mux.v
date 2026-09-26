// 4X1 Multiplexer using boolean expressions

module tb_4_1_mux();

reg n0, n1, n2,n3;
reg s0, s1;
wire y;

mux_4x1 dut (n0,n1,n2,n3,s0,s1,y);

initial begin

n0=0;
n1=0;
n2=0;
n3=0;

s0=0;
s1=0;
#5;

n0=0;
n1=1;
n2=0;
n3=1;
s0=0;
s1=1;


#5;
n0=1;
n1=0;
n2=1;
n3=0;
s0=1;
s1=0;

#5;
n0=1;
n1=1;
n2=1;
n3=0;
s0=1;
s1=1;


$finish;

end

endmodule


// 4x1 Multiplexer using conditional logic ternary operator
module tb_4_1_mux();

reg n0, n1, n2,n3;
reg s0, s1;
wire y;

mux_4x1 dut (n0,n1,n2,n3,s0,s1,y);

initial begin

n0=0;
n1=0;
n2=0;
n3=0;

s0=0;
s1=0;
#5;

n0=0;
n1=1;
n2=0;
n3=1;
s0=0;
s1=1;


#5;
n0=1;
n1=0;
n2=1;
n3=0;
s0=1;
s1=0;

#5;
n0=1;
n1=1;
n2=1;
n3=0;
s0=1;
s1=1;



$finish;
end

endmodule


// 4x1 Multiplexer using behavioural modelling using case

module tb_4_1_mux();

reg [3:0]n;
[1:0]sel;
wire y;

mux_4x1 dut(n, sel, y);
initial 
n=$random;

always @(*) begin

    n[0]=$random & 3'h7;
    n[1]=$random & 3'h7;
    n[2]=$random & 3'h7;
    n[3]=$random & 3'h7;

    #10;
    sel = 2'b00;
    #10;
    sel = 2'b01;
    #10;
    sel = 2'b10;
    #10;
    sel = 2'b11;
        

    end


$finish;

endmodule





