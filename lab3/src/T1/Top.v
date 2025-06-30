module Top (
    input   [7:0]                       sw,
    output  [7:0]                       led
);
assign led = {sw[0],sw[1],sw[2],sw[3],sw[4],sw[5],sw[6],sw[7]};
endmodule