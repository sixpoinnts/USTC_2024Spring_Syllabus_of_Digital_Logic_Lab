module Top(
    input                   clk,
    input                   rst,
    input       [2:0]       a,
    input       [3:0]       b,
    input                   start,
    output [2:0]            seg_an,
    output [3:0]            seg_data
);

wire finish;
wire [7:0]res;

Segment segment(
    .clk(clk),
    .rst(rst),
    .output_data({24'b0,res}),
    .output_valid(8'b00000011),
    .seg_data(seg_data),
    .seg_an(seg_an)
);

MUL #(.WIDTH(4)) mul(
    .clk(clk),
    .rst(rst),
    .start(start),
    .a(a),
    .b(b),

    .finish(finish),
    .res(res)
);
endmodule