module SW_Input_tb();
reg clk;
reg [7:0] sw;
initial begin
    clk = 0;
    forever begin
        #5 clk = ~clk;
    end
end

initial begin
    sw=8'h31;
    #20;
    sw=8'h33;
end

Input swi(
    .clk(clk),
    .rst(0),
    .sw(sw)
);

endmodule