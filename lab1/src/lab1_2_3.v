module MAX3 (
    input   [7:0]         num1, num2, num3,
    output  [7:0]         max
);
wire [7:0] temp;
MAX2 findmax1(
    .num1(num1),
    .num2(num2),
    .max(temp)
);
MAX2 findmax2(
    .num1(temp),
    .num2(num3),
    .max(max)
);
endmodule
