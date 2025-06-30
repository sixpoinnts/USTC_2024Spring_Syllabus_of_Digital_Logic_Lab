module Control (
    input                   [ 0 : 0]            clk,
    input                   [ 0 : 0]            rst,
    input                   [ 0 : 0]            btn,

    input                   [ 5 : 0]            check_result,
    output      reg         [ 0 : 0]            check_start,
    output      reg         [ 0 : 0]            timer_en,
    output      reg         [ 0 : 0]            timer_set,
    input                   [ 0 : 0]            timer_finish,

    output      reg         [ 1 : 0]            led_sel,
    output      reg         [ 1 : 0]            seg_sel,
    output      reg         [ 0 : 0]            generate_random
);

reg [1:0] current_state, next_state;
localparam WAIT = 2'd0;
localparam START = 2'd1;
localparam CHECK = 2'd2;
localparam ENDIT = 2'd3;

always @(posedge clk) begin
    if (rst)
        current_state <= WAIT;
    else
        current_state <= next_state;
end

reg btn_reg1,btn_reg2;
wire btn_change;
always @(posedge clk) begin
    if(rst)begin
        btn_reg1 <= 0;
        btn_reg2 <= 0;
    end
    else begin
        btn_reg1 <= btn;
        btn_reg2 <= btn_reg1;
    end
end
assign btn_change = (btn_reg1 & (~btn_reg2));

reg flag;
always @(*) begin
    next_state = current_state;

    case (current_state)
            WAIT: begin
                timer_set=1;
                flag=0;
                led_sel=0;//不亮
                seg_sel=0;//000
                generate_random=1;
                if(btn_change) begin   
                    next_state = START;
                end
            end
            START: begin
                generate_random=0;
                led_sel=2'd1;//流水灯
                timer_en=1;
                timer_set=0;
                seg_sel=2'b1;//倒计时
                if(timer_finish)begin
                    next_state=ENDIT;
                end
                if(btn_change) begin
                    next_state = CHECK;
                end
            end    
            CHECK: begin
                check_start=1;
                led_sel=2'd2;//显示答案
                if(check_result==6'b100000) begin
                    flag=1;
                    check_start=0;
                    next_state=ENDIT;
                end
                if(btn_change) begin
                    check_start=0;
                    next_state=START;
                end
            end
            ENDIT: begin
                timer_en=0;
                if(flag)begin
                    led_sel=2'b11;
                    seg_sel=2'd2;
                    flag=0;
                end
                else begin
                    led_sel=0;
                    seg_sel=2'd3;
                end
                if(btn_change) begin
                    next_state = WAIT;
                end
            end   
    endcase
end
endmodule