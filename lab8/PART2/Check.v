module Check(
    input                   [ 0 : 0]            clk,
    input                   [ 0 : 0]            rst,

    input                   [11 : 0]            input_number,
    input                   [11 : 0]            target_number,
    input                   [ 0 : 0]            start_check,

    output                  [ 5 : 0]            check_result
);
// 模块内部用寄存器暂存输入信号，从而避免外部信号突变带来的影响
reg [11:0] current_input_data, current_target_data;
always @(posedge clk) begin
    if (rst) begin
        current_input_data <= 0;
        current_target_data <= 0;
    end
    else if (start_check) begin 
        current_input_data <= input_number;
        current_target_data <= target_number;
    end
end

// 使用组合逻辑产生比较结果
wire [3:0] target_number_3, target_number_2, target_number_1;
wire [3:0] input_number_3, input_number_2, input_number_1;
assign input_number_1 = current_input_data[3:0];
assign input_number_2 = current_input_data[7:4];
assign input_number_3 = current_input_data[11:8];
assign target_number_1 = current_target_data[3:0];
assign target_number_2 = current_target_data[7:4];
assign target_number_3 = current_target_data[11:8];

reg i1t1, i1t2, i1t3, i2t1, i2t2, i2t3, i3t1, i3t2, i3t3;
always @(*) begin
    i1t1 = (input_number_1 == target_number_1);
    i1t2 = (input_number_1 == target_number_2);
    i1t3 = (input_number_1 == target_number_3);
    i2t1 = (input_number_2 == target_number_1);
    i2t2 = (input_number_2 == target_number_2);
    i2t3 = (input_number_2 == target_number_3);
    i3t1 = (input_number_3 == target_number_1);
    i3t2 = (input_number_3 == target_number_2);
    i3t3 = (input_number_3 == target_number_3);
end

// TODO：按照游戏规则，补充 check_result 信号的产生逻辑
assign check_result[5] = i1t1 & i2t2 & i3t3;
assign check_result[4] = (i1t1 & i2t2 & ~i3t3)|(~i1t1 & i2t2 & i3t3)|(i1t1 & ~i2t2 & i3t3);
assign check_result[3] = (i1t1 & ~i2t2 & ~i3t3)|(~i1t1 & i2t2 & ~i3t3)|(~i1t1 & ~i2t2 & i3t3);

assign check_result[2] = (i1t2 | i1t3) & (i2t1 | i2t3) & (i3t1 | i3t2);
assign check_result[1] = ((i1t2 | i1t3) & (i2t1 | i2t3) & ~(i3t1 | i3t2)) | (~(i1t2 | i1t3) & (i2t1 | i2t3) & (i3t1 | i3t2)) | ((i1t2 | i1t3) & ~(i2t1 | i2t3) & (i3t1 | i3t2));
assign check_result[0] = ((i1t2 | i1t3) & ~(i2t1 | i2t3) & ~(i3t1 | i3t2)) | (~(i1t2 | i1t3) & (i2t1 | i2t3) & ~(i3t1 | i3t2)) | (~(i1t2 | i1t3) & ~(i2t1 | i2t3) & (i3t1 | i3t2));

endmodule
