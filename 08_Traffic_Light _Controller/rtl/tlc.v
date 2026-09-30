`timescale 1ns / 1ps

// this circuits works based on two road junctions, Road A and Road B

module tlc(
    input clk, rst,

    output A_red,
    output A_yellow,
    output A_green,

    output B_red,
    output B_yellow,
    output B_green
    );

    reg[1:0] state, nstate;
    reg[3:0] timer;

    parameter s0=2'b00;
    parameter s1=2'b01;
    parameter s2=2'b10;
    parameter s3=2'b11;

    // state register logic - seq reset logic

    always@(posedge clk) begin
    if(rst)
        state<=s0;
    else
        state<=nstate;
    end

    // timer logic
    always@(posedge clk)
    if(rst)
        timer<=4'b0000;
    else begin
        if(state==s0&& timer==9 ||
            state==s1&&timer==2||
            state==s2&&timer==9||
            state==s3&&timer==2 )
            timer<=4'b0000;
        else
            timer<=timer+1'b1;
    end

    //combinational next state logic 
    always@(*)begin
        nstate=s0;
        case(state)

        s0: begin
            if(timer==9)
                nstate=s1;
            else 
                nstate=s0;   
        end
        s1: begin
            if(timer==2)
                nstate=s2;
            else 
                nstate=s1;   
        end
        s2: begin
            if(timer==9)
                nstate=s3;
            else
                nstate=s2;    
        end
        s3: begin
            if(timer=2)
                nstate=s0;
            else
                nstate=s3;
        end
        default:nstate=s0;   
        endcase
    end

    // combinational output logic

    always@(*) begin
        case(state)
        s0:begin
            A_red=1'b0;
            A_yellow=1'b0;
            A_green=1'b1;

            B_red=1'b1;
            B_yellow=1'b0;
            B_green=1'b0;
        end
        s1:begin
            A_red=1'b0;
            A_yellow=1'b1;
            A_green=1'b0;

            B_red=1'b1;
            B_yellow=1'b0;
            B_green=1'b0;
        end
        s2:begin
            A_red=1'b1;
            A_yellow=1'b0;
            A_green=1'0;

            B_red=1'b0;
            B_yellow=1'b0;
            B_green=1'b1;
        end
        s0:begin
            A_red=1'b1;
            A_yellow=1'b0;
            A_green=1'b0;

            B_red=1'b0;
            B_yellow=1'b1;
            B_green=1'b0;
        end



        default: begin

        end
        endcase

    end



endmodule
