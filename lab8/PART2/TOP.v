module Top (
    input                   [ 0 : 0]            clk,
    input                   [ 0 : 0]            btn,
    input                   [ 7 : 0]            sw,

    output                  [ 7 : 0]            led,
    output                  [ 2 : 0]            seg_an,
    output                  [ 3 : 0]            seg_data
);

wire rst = sw[7];
wire [3:0] hex;
wire pulse;
wire [31:0] dout;

Input swi(
    .clk(clk),
    .rst(rst),
    .sw(sw),
    .hex(hex),
    .pulse(pulse)
);

ShiftReg shift(
    .clk(clk),
    .rst(rst),
    .hex(hex),
    .pulse(pulse),
    .dout(dout)
);

wire start_check;
wire [5:0] check_result;
wire generate_random;
wire [11:0] random_data;

Random ran(
    .clk(clk),
    .rst(rst),
    .generate_random(generate_random),
    .sw_seed(dout[11:0]),
    .timer_seed(current_time[19:12]),
    .random_data(random_data)
);

Check check(
    .clk(clk),
    .rst(rst),
    .input_number(dout[11:0]),
    .target_number(random_data),
    .start_check(start_check),
    .check_result(check_result)
);

wire btnp;

edge_capture(
    .clk(clk),
    .rst(rst),
    .sig_in(btn),
    .pos_edge(btnp)
);

wire en, set, finish;
wire [7:0] minute, second;
wire [11:0] micro_second;

Timer timer(
    .clk(clk),
    .rst(rst),
    .set(set),
    .en(en),
    .minute(minute),
    .second(second),
    .micro_second(micro_second),
    .finish(finish)
);

wire [7:0] minute_out, second_out;
wire [11:0] micro_second_out;

Hex2BCD #(8) hex1(
    .bin(minute),
    .out(minute_out)
);

Hex2BCD #(8) hex2(
    .bin(second),
    .out(second_out)
);

Hex2BCD #(12) hex3(
    .bin(micro_second),
    .out(micro_second_out)
);

wire [1:0] led_sel,seg_sel;

Control control(
    .clk(clk),
    .rst(rst),
    .btn(btnp),
    .check_result(check_result),
    .check_start(start_check),
    .timer_en(en),
    .timer_set(set),
    .timer_finish(finish),
    .led_sel(led_sel),
    .seg_sel(seg_sel)
);

wire [7:0] flow_led, led_res;
wire [7:0] ledsrc3;
assign  ledsrc3={2'b0,check_result};

MUX4 #(8) mux1(
    .src0(8'b00000000),
    .src1(flow_led),
    .src2(ledsrc3),
    .src3(8'b11111111),
    .sel(led_sel),
    .res(led_res)
);

LED_Flow ledflow(
    .clk(clk),
    .btn(btn),
    .led(flow_led)
);

LED ledd(
    .ledres(led_res),
    .led(led)
);

wire [31:0] seg_res;
wire [31:0] current_time;

assign current_time={4'b0,minute_out[7:0],second_out[7:0],micro_second_out[11:0]};

MUX4 #(32) mux2(
    .src0(32'h0),
    .src1(current_time),
    .src2(32'h88888888),
    .src3(32'h44444444),
    .sel(seg_sel),
    .res(seg_res)
);

wire [7:0] output_vaild;

Seg_vaild vaild(
    .clk(clk),
    .rst(rst),
    .second(second),
    .output_vaild(output_vaild)
);

Segment segment(
    .clk(clk),
    .rst(rst),
    .output_data(seg_res),
    .output_valid(output_vaild),
    .seg_data(seg_data),
    .seg_an(seg_an)
);

endmodule
