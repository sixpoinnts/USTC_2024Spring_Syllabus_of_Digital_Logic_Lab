module MUL7_tb();
reg clk, rst,src_vaild;
reg [31:0] src;
wire ready,res,res_valid;

initial begin
    clk = 0; 
end
always #5 clk = ~clk;

initial begin
    rst = 0;
    src_vaild = 1;
    #20;
    src = 32'd21; 
    #20;
    src = 32'd22;
    #330;
    src = 32'd14;
    #20;
    rst=1;
end


MUL7 tb (
    .clk(clk),
    .rst(rst),
    .src(src),
    .src_vaild(src_vaild),
    .ready(ready),
    .res(res),
    .res_valid(res_valid)
);
endmodule