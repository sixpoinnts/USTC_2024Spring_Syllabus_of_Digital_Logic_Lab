module Shifter2(
    input                   [31 : 0]        src0,
    input                   [ 4 : 0]        src1,
    output         reg      [31 : 0]        res1,       //逻辑右移
    output         reg      [31 : 0]        res2        //算术右移
);
// Write your code here
initial begin
    res1 <= src0;
    res2 <= src0;
end

always @(*) begin
    if(src1[0]) begin
        res1 = {1'b0,res1[31:1]};
        res2 = {{1{res2[31]}},res2[31:1]}; 
    end
    if(src1[1]) begin
        res1 = {2'b0,res1[31:2]};
        res2 = {{2{res2[31]}},res2[31:2]}; 
    end
    if(src1[2]) begin
        res1 = {4'b0,res1[31:4]};
        res2 = {{4{res2[31]}},res2[31:4]}; 
    end
    if(src1[3]) begin
        res1 = {8'b0,res1[31:8]};
        res2 = {{8{res2[31]}},res2[31:8]}; 
    end
    if(src1[4]) begin
        res1 = {16'b0,res1[31:16]};
        res2 = {{16{res2[31]}},res2[31:16]}; 
    end
end
// End of your code
endmodule
