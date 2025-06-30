module Shifter3_tb();
reg     [31:0] src0,src1;
wire    [31:0] res1,res2;

initial begin
    src0=32'h1234; src1=32'h00000;
    repeat(32) begin
        #50 src1 = src1 + 1;
    end
end
    
Shifter3 sh1(
    .src0(src0),
    .src1(src1[4:0]),
    .res1(res1),
    .res2(res2)
);
endmodule
