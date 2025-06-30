module check_tb();
reg clk;
reg [11:0] input_num;

initial begin
    clk = 0;
    forever begin
        #5 clk = ~clk;
    end
end

initial begin
    input_num = 12'b0000_0010_0011;
    #50;
    input_num = 12'b0000_0101_0010;
    #50
    input_num = 12'b0101_0010_0000;
end

Check chk(
    .clk(clk),
    .rst(0),
    .input_number(input_num),
    .target_number(12'b0101_0010_0000),
    .start_check(1)
);

endmodule