module MUL_tb #(
    parameter WIDTH = 32
) ();
reg  [WIDTH-1:0]    a, b;
reg                 rst, clk, start;
wire [2*WIDTH-1:0]  res;
wire                finish;
integer             seed;

initial begin
    clk = 0;
    seed = 2023; // 种子值
    forever begin
        #5 clk = ~clk;
    end
end

initial begin
    rst = 1;
    start = 0;
    #20;
    rst = 0;
    #20;
    repeat (5) begin
        a = $random(seed);          // $random 返回的是 32 位随机数，如果你需要得到少于 32 位的随机数，可以通过 % 运算得到
        b = $random(seed + 1);      // 你可以通过设置种子值改变随机数的序列
        start = 1;
        #20 start = 0;
        #380;
    end
    $finish;
end

MUL mul(
    .clk        (clk),
    .rst        (rst),
    .start      (start),
    .a          (a),
    .b          (b),
    .res        (res),
    .finish     (finish)
);
endmodule
