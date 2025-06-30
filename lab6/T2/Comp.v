module Comp(
    input   [31:0]  a,b,
    output  [0:0]  ul,sl
);

wire [31:0] s;
wire [0:0] co;

AddSub addsub(
    .a(a),
    .b(b),
    .out(s),
    .co(co)
);

assign ul = ~co;
assign sl = (a[31]==b[31])?(s[31]):(a[31]);

endmodule