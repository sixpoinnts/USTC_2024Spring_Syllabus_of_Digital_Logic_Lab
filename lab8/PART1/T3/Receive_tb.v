module Receive_tb();
reg clk, rst, din;
reg  [7 : 0] test_data, temp;
wire [7 : 0] din_data;
wire din_vld;

initial begin
    rst = 1;
    #10;
    rst = 0;
end

initial begin
    clk = 0;
    forever begin
        #5 clk = ~clk;
    end
end

initial begin
    din = 1;
    #20;
    repeat(1) begin
        din = 0;
        #8670;
        test_data = "a";        // 可以更改为其他测试数据
        repeat(8) begin
            temp = test_data & 8'B1;
            din = temp[0];
            test_data = test_data >> 1;
            #8670;
        end
        din = 1;
        #8670;
    end
end

Receive receive (
    .clk        (clk),
    .rst        (rst),
    .din        (din),
    .din_vld    (din_vld),
    .din_data   (din_data)
);
endmodule
