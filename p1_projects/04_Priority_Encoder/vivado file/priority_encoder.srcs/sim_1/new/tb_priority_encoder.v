`timescale 1ns / 1ps


module tb_priority_encoder();
// port declaration
reg [3:0]D;
reg [1:0]expected_Y;
reg expected_V;
wire [1:0]Y;
wire V;
integer i;

//module instantiation
priority_encoder dut(.D(D), .Y(Y), .V(V));

// testing values and logic

initial begin 

for(i=0;i<16;i=i+1) begin
    D=i; #5;
    if (D[3]) begin
        expected_Y = 2'b11;
        expected_V = 1'b1;
        if(Y !==expected_Y || V !==expected_V)
            $display("FAILED: actual Y=%b, actual V=%b, expected Y=%b, expected V=%b",Y,V,expected_Y, expected_V);
        else
            $display("PASS: actual Y=%b, actual V=%b, expected Y=%b, expected V=%b",Y,V,expected_Y, expected_V);    
    end
    else if (D[2]) begin
        expected_Y = 2'b11;
        expected_V = 1'b1;
        if(Y !==expected_Y || V !==expected_V)
            $display("FAILED: actual Y=%b, actual V=%b, expected Y=%b, expected V=%b",Y,V,expected_Y, expected_V);
        else
            $display("PASS: actual Y=%b, actual V=%b, expected Y=%b, expected V=%b",Y,V,expected_Y, expected_V);
    end
    else if (D[1]) begin
        expected_Y = 2'b01;
        expected_V = 1'b1;
        if(Y !==expected_Y || V !==expected_V)
            $display("FAILED: actual Y=%b, actual V=%b, expected Y=%b, expected V=%b",Y,V,expected_Y, expected_V);
        else
            $display("PASS: actual Y=%b, actual V=%b, expected Y=%b, expected V=%b",Y,V,expected_Y, expected_V);    
    end
    else if (D[0]) begin
        expected_Y = 2'b00;
        expected_V = 1'b1;
        if(Y !==expected_Y || V !==expected_V)
            $display("FAILED: actual Y=%b, actual V=%b, expected Y=%b, expected V=%b",Y,V,expected_Y, expected_V);
        else
            $display("PASS: actual Y=%b, actual V=%b, expected Y=%b, expected V=%b",Y,V,expected_Y, expected_V);
    end
    else begin 
        expected_Y = 2'b00;
        expected_V = 1'b0;
        if(Y !==expected_Y || V !==expected_V)
            $display("FAILED: actual Y=%b, actual V=%b, expected Y=%b, expected V=%b",Y,V,expected_Y, expected_V);
        else
            $display("PASS: actual Y=%b, actual V=%b, expected Y=%b, expected V=%b",Y,V,expected_Y, expected_V);
    end   
end

$finish;

end





endmodule
