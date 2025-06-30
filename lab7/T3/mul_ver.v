module MUL_ver #(
    parameter WIDTH = 32
)(
    input                   [ 0 : 0]        clk,
    input                   [ 0 : 0]        rst,
    input                   [ 0 : 0]        start,
    input                   [WIDTH-1:0]     a,
    input                   [WIDTH-1:0]     b,
    output      reg         [2*WIDTH-1:0]   res,
    output      reg         [ 0 : 0]        finish
);
reg [WIDTH-1:0] temp_a, temp_b;
always @(posedge clk) begin
    if (rst) begin
        res <= 0;
        finish <= 1'B0;
    end
    else if (start) begin
        temp_a <= a;
        temp_b <= b;
        res <= temp_a * temp_b;
        finish <= 1'B1;
    end
    else
        finish <= 1'B0;
end
endmodule
