module MAX3 (
    input       [7:0]         num1, num2, num3,
    output reg  [7:0]         max
);
always @(*) begin
    if(num1>num2)
        max = (num1>num3) ? num1 : num3;
    else
        max = (num2>num3) ? num2 : num3;
end
endmodule