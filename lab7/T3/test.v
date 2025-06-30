module test_mult (
    input                   [ 0 : 0]        clk,
    input                   [ 3 : 0]        a,
    input                   [ 3 : 0]        b,
    output      reg         [ 7 : 0]        out
);

reg [3:0]      a_reg;
reg [3:0]      b_reg;
reg [0:0]      rst;
wire [7:0]     out_wire;
wire [0:0]     finish;

always @(posedge clk) begin
    a_reg <= a;
    b_reg <= b;
    out <= out_wire;
end

// 下面例化一个组合逻辑乘法器，MUL 模块的具体实现此处省略。
MUL_ver mul(
    .clk(clk),
    .rst(rst),
    .start(start),
    .a(a_reg),
    .b(b_reg),
    .res(out_wire),
    .finish(finish)
);
endmodule
