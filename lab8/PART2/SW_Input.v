module Input(
    input                   [ 0 : 0]            clk,
    input                   [ 0 : 0]            rst,
    input                   [ 7 : 0]            sw,

    output      reg         [ 3 : 0]            hex,
    output                  [ 0 : 0]            pulse
);
// 三级寄存器边沿检测
reg [7:0] sw_reg_1, sw_reg_2, sw_reg_3;
always @(posedge clk) begin
    if (rst) begin
        sw_reg_1 <= 0;
        sw_reg_2 <= 0;
        sw_reg_3 <= 0;
    end
    else begin
        // TODO：补充边沿检测的代码
        sw_reg_1 <= sw;
        sw_reg_2 <= sw_reg_1;
        sw_reg_3 <= sw_reg_2;
    end
end

// TODO：检测上升沿
wire [7:0] sw_change = sw_reg_2 & (~sw_reg_3);

// TODO：编写代码，产生 hex 和 pulse 信号。
// Hint：这两个信号均为组合逻辑产生。 译码器？
always @(*) begin
    case (sw_change)
        8'b1:hex = 4'd0;
        8'b10:hex = 4'd1;
        8'b100:hex = 4'd2;
        8'b1000:hex = 4'd3;
        8'b10000:hex = 4'd4;
        8'b100000:hex = 4'd5;
        8'b1000000:hex = 4'd6;
        8'b10000000:hex = 4'd7;
        default: hex = 4'b0;
    endcase
end
assign pulse = (sw_change!=0);

endmodule