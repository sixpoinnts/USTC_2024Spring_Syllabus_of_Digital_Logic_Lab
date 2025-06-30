`timescale 1ns / 1ps

module q3_tb();

reg            clk;
reg            a;
reg            b;
reg     [3:0]       c;

initial clk=1'b1;
always #5 clk=~clk;

initial begin
    a=0;
    b=0;
    c=4'd0;
    #10;
    a=1'b1;
    b=1'b0;
    c=4'd1;
    #10;
    b=1'b1;
    #5;
    b=1'b0;
    #5;
    c=4'd2;
    #10;
    a=1'b0;
    b=1'b1;
    #10;
    a=1'b1;
    c=4'd3;
    #20;
    a=1'b0;
    b=1'b0;
    #5;
    b=1'b1;
    #5;
    a=1'b1;
    c=4'd4;
    #10;
    b=1'b0;
end
endmodule
