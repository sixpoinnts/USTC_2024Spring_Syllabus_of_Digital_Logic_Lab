module Adder2_tb();
reg     [31:0] a,b;
reg     [ 0:0] ci;
wire    [31:0] s;
wire    [ 0:0] co;  


initial begin
    a=32'hffff; b=32'hffff; ci=1'b1;
    #10;
    a=32'h0f0f; b=32'hf0f0; ci=1'b1;
    #10;
    a=32'h1234; b=32'h4321; ci=1'b0;
end

Adder2 adder(
    .a(a),
    .b(b),
    .ci(ci),
    .s(s),
    .co(co)
);

endmodule