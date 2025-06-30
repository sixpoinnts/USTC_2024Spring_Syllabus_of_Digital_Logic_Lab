module adder2bit(
    input           [1:0]         a,
    input           [1:0]         b,
    output     reg     [1:0]         out,
    output                        Cout
);
// Write your code here
wire temp,temp_out1,temp_out0;
HalfAdder dw(
    .a(a[0]),
    .b(b[0]),
    .s(temp_out0),
    .c(temp)
);
FullAdder gw(
    .a(a[1]),
    .b(b[1]),
    .cin(temp),
    .s(temp_out1),
    .cout(Cout)
);
always @(*) begin
    out[1]=temp_out1;
    out[0]=temp_out0;
end
// End of your code
endmodule