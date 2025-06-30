module Top(
    input  [3:0]            sw,
    output [7:0]            led
);
assign led[6:2]=5'b0;
encode segment(
    .I(sw),
    .en(led[7]),
    .Y(led[1:0])
);
endmodule