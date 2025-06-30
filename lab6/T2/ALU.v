module ALU(
    input                   [31 : 0]        src0, src1,
    input                   [11 : 0]        sel,
    output                  [31 : 0]        res
);
// Write your code here
wire [31:0] adder_out;
wire [31:0] sub_out;
wire [0 :0] slt_out;
wire [0 :0] sltu_out;

Adder adder(
    .a(src0),
    .b(src1),
    .ci(1'B0),
    .s(adder_out),
    .co()
);

AddSub sub(
    .a(src0),
    .b(src1),
    .out(sub_out),
    .co()
);

Comp comp(
    .a(src0),
    .b(src1),
    .ul(sltu_out),
    .sl(slt_out)
);

// TODO：完成 res 信号的选择
always @(*) begin
    case(sel)
        12'h001:    res = adder_out;
        12'h002:    res = sub_out;
        12'h004:    res = slt_out;
        12'h008:    res = sltu_out;
        12'h010:    res = src0 & src1;
        12'h020:    res = src0 | src1;
        12'h040:    res = ~(src0 | src1);
        12'h080:    res = src0 ^ src1;
        12'h100:    res = src0 << src1[4:0];
        12'h200:    res = src0 >> src1[4:0];
        12'h400:    res = src0 >>> src1[4:0];
        12'h800:    res = src1;
    endcase
end
// End of your code
endmodule
