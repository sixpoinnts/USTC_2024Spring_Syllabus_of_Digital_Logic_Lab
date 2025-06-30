module AddSub (
    input                   [ 31 : 0]        a, b,
    output                  [ 31 : 0]        out,
    output                  [ 0  : 0]        co
);

Adder fa1(
    .a(a),
    .b(~b),
    .ci(1'B1),
    .s(out),
    .co(co)
);

endmodule