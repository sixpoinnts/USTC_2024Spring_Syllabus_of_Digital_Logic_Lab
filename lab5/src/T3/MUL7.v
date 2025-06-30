module MUL7(
    input                               clk,            // 时钟信号
    input                               rst,            // 复位信号，使状态机回到初始态
    input               [31 : 0]        src,            // 输入数据
    input                               src_valid,      // 表明输入结果是否有效
    output      reg                     ready,          // 表明是否正在检测
    output      reg                     res,            // 输出结果
    output      reg                     res_valid       // 表明输出结果是否有效
);
reg [5:0] count;
initial begin
    count =6'b100000;
    ready =1;
end 
reg [31:0] srcin;
// 状态空间位数 n
parameter WIDTH = 3;
// 状态变量
reg [WIDTH-1: 0] current_state, next_state;
initial begin
    current_state<=0;
    next_state<=0;
end

// 为了便于标识，我们用局部参数定义状态的别名代替状态编码
localparam STATE_NAME_0 = 3'd0;
localparam STATE_NAME_1 = 3'd1;
localparam STATE_NAME_2 = 3'd2;
localparam STATE_NAME_3 = 3'd3;
localparam STATE_NAME_4 = 3'd4;
localparam STATE_NAME_5 = 3'd5;
localparam STATE_NAME_6 = 3'd6;

//新输入
always @(posedge clk) begin
    if(!rst && src_valid && ready == 1) begin
        srcin <= src;
        count <= 6'b100000;
        ready <= 0;
        res_valid <= 0;
    end
end

// ==========================================================
// Part 1: 使用同步时序进行状态更新，即更新 current_state 的内容。
// ==========================================================
always @(posedge clk) begin
    // 首先检测复位信号
    if (rst)  begin
        current_state <= 0;
        count <= 6'b100000;
    end
    // 随后再进行内容更新
    else begin
        current_state <= next_state;
        if(count!=6'd0) begin
            count<= count -1;
        end
        else begin
            count<= 6'd0;
            ready<=1;
            res_valid<=1;
        end
    end
end

// ==========================================================
// Part 2: 使用组合逻辑判断状态跳转逻辑，即根据 current_state 与
//         其他信号确定 next_state。
// ==========================================================
// 一般使用 case + if 语句描述跳转逻辑
always @(*) begin
    // 先对 next_state 进行默认赋值，防止出现遗漏
    next_state = current_state;
    if(src_valid)begin
        if(count!=0) begin
            case (current_state)
                STATE_NAME_0: begin
                    if(srcin[count])
                        next_state <= STATE_NAME_1;
                    else
                        next_state <= STATE_NAME_0;
                end
                STATE_NAME_1: begin
                    if(srcin[count])
                        next_state <= STATE_NAME_3;
                    else
                        next_state <= STATE_NAME_2;
                end
                    STATE_NAME_2: begin
                    if(srcin[count])
                        next_state <= STATE_NAME_5;
                    else
                        next_state <= STATE_NAME_4;
                end
                STATE_NAME_3: begin
                    if(srcin[count])
                        next_state <= STATE_NAME_0;
                    else
                        next_state <= STATE_NAME_6;
                end
                STATE_NAME_4: begin
                    if(srcin[count])
                        next_state <= STATE_NAME_2;
                    else
                        next_state <= STATE_NAME_1;
                end
                STATE_NAME_5: begin
                    if(srcin[count])
                        next_state <= STATE_NAME_4;
                    else
                        next_state <= STATE_NAME_3;
                end
                STATE_NAME_6: begin
                    if(srcin[count])
                        next_state <= STATE_NAME_6;
                    else
                        next_state <= STATE_NAME_5;
                end
            endcase
        end
    end
end

// ==========================================================
// Part 3: 使用组合逻辑描述状态机的输出。这里是 mealy 型状态机
//         与 moore 型状态机区别的地方。
// ==========================================================
// 可以直接使用 assign 进行简单逻辑的赋值
//assign out1 = ......;
// 也可以用 case + if 语句进行复杂逻辑的描述
always @(*) begin
    if(ready==1 && res_valid==1)
        case (current_state)
            STATE_NAME_0: begin
                res<=1;
            end
            default: begin
                res<=0;
            end
        endcase
end
endmodule
