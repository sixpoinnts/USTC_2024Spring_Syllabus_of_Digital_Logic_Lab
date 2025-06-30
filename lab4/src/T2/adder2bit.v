module adder2bit(
    input           [1:0]         a,
    input           [1:0]         b,
    output          [1:0]         out,
    output                        Cout
);
// Write your code here
wire temp;
HalfAdder dw(
    .a(a[0]),
    .b(b[0]),
    .s(out[0]),
    .c(temp)
);
FullAdder gw(
    .a(a[1]),
    .b(b[1]),
    .cin(temp),
    .s(out[1]),
    .cout(Cout)
);
// End of your code
endmodule