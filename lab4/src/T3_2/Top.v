module Top(
    input  [7:0]            sw,
    output [7:0]            led
);
assign led[7:1]=7'b0;
multiple5 segment(
    .num(sw[7:0]),
    .ismultiple5(led[0])
);
endmodule