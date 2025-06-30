module MUL #(
    parameter                               WIDTH = 32
) (
    input                   [ 0 : 0]            clk,
    input                   [ 0 : 0]            rst,
    input                   [ 0 : 0]            start,
    input                   [WIDTH-1 : 0]       a,
    input                   [WIDTH-1 : 0]       b,
    output      reg         [2*WIDTH-1:0]       res,
    output      reg         [ 0 : 0]            finish
);
reg [2*WIDTH-1 : 0]     multiplicand;       // 被乘数寄存器
reg [  WIDTH-1 : 0]     multiplier;         // 乘数寄存器
reg [2*WIDTH-1 : 0]     product;            // 乘积寄存器
reg [2*WIDTH-1 : 0]     add;

localparam IDLE = 2'b00;            // 空闲状态。这个周期寄存器保持原值不变。当 start 为 1 时跳转到 INIT。
localparam INIT = 2'b01;            // 初始化。下个周期跳转到 CALC
localparam CALC = 2'b10;            // 计算中。计算完成时跳转到 DONE
localparam DONE = 2'b11;            // 计算完成。下个周期跳转到 IDLE
reg [1:0] current_state, next_state;

reg [0:0] calc;
reg [0:0] done;

// 请完成有限状态机以及乘法器模块的设计

initial begin
    current_state<=0;
    next_state<=0;
    multiplicand<=0;
    multiplier<=0;
    product<=0;
    calc<=0;
    done<=0;
end

// ==========================================================
// Part 1: 使用同步时序进行状态更新，即更新 current_state 的内容。
// ==========================================================

always @(posedge clk) begin
    // 首先检测复位信号
    if(rst) begin
        current_state<=IDLE;
        product<=0;
        multiplicand<=0;
        multiplier<=0;
        calc<=0;
        done<=0;
    end
    // 随后再进行内容更新
    else begin
        current_state = next_state;
    end
end

// ==========================================================
// Part 2: 使用组合逻辑判断状态跳转逻辑，即根据 current_state 与
//         其他信号确定 next_state。
// ==========================================================

always @(*) begin
    // 先对 next_state 进行默认赋值，防止出现遗漏
    next_state = current_state;

    case (current_state)
            IDLE: begin
                if(start) begin   
                    next_state = INIT;
                end
            end
            INIT: begin
                multiplicand = {32'b0,{a[WIDTH-1:0]}};
                multiplier = b;
                product = 0;
                finish=0;
                next_state = CALC;
            end
            CALC: begin
                calc<=1;
                if(multiplier==0) begin
                    calc<=0;
                    next_state = DONE;
                end
            end
            DONE: begin
                if(!clk)
                    done<=1;
                if(clk && done) begin
                    done<=0;
                    next_state = IDLE;
                end
            end         
    endcase
end

always @(posedge clk && calc) begin
    multiplicand={{multiplicand[62:0]},1'b0};
    multiplier={1'b0,{multiplier[31:1]}};
end

always @(posedge clk) begin
    if(multiplier[0]==1)
        add = multiplicand;
    else
        add = 0;
    product = product + add;
end

// ==========================================================
// Part 3: 使用组合逻辑描述状态机的输出。这里是 mealy 型状态机
//         与 moore 型状态机区别的地方。
// ==========================================================
always @(*)
    finish = (current_state == DONE);

always @(finish)begin
    res = product;
    multiplicand = 0;
end

endmodule