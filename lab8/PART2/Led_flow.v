module LED_Flow (
    input                   clk,
    input                   btn,
    output reg [7:0]        led
);

reg [31:0] count_1hz;
wire rst;
parameter TIME_CNT = 50_000_000;

assign rst = btn;   // Use button for RESET

always @(posedge clk) begin
    if (rst)
        count_1hz <= 0;
    else if (count_1hz >= TIME_CNT)
        count_1hz <= 0;
    else
        count_1hz <= count_1hz + 1;
end

always @(posedge clk) begin
    if (rst)
        led <= 8'b0000_1111;
    else if (count_1hz == 1) begin
        led <= {led[6:0], led[7]};
    end
end
endmodule
