module CounterPro #(
    parameter   MAX_VALUE = 32'd50_000_000
)(
    input                   clk,
    input                   btn,
    output reg [7:0]        led           
);

wire rst;
assign rst=btn;

reg [31:0] counter;

always @(posedge clk) begin
    if (rst) begin
        counter <= 0;
        led=8'b1111_1111;
    end
    else begin
        if (counter >= MAX_VALUE) begin
            counter <= 0;
            led<=~led;
        end
        else
            counter <= counter + 32'd1;
    end
end

endmodule