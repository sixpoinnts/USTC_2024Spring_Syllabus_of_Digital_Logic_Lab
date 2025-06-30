module Top(
    input  [3:0]            sw,
    output [7:0]            led
);
assign led[7:3]=5'b0;
adder2bit segment(
    .a(sw[3:2]),
    .b(sw[1:0]),
    .out(led[1:0]),
    .Cout(led[2])
);
endmodule