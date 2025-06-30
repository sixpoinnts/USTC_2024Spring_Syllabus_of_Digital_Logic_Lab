module Top(
    input                   clk,
    input                   btn,
    output [2:0]            seg_an,
    output [3:0]            seg_data
);
Segment segment(
    .clk(clk),
    .rst(btn),
    .output_data(32'h22111695),     // <- 改为你学号中的 8 位数字
    .seg_data(seg_data),
    .seg_an(seg_an)
);
endmodule