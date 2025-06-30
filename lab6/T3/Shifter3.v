module Shifte3(
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
    
    case (src1[2:0])
        5'd0:begin
            res1=src0;
            res2=src0;
        end 
        5'd1:begin
            res1={1'b0,src0[31:1]};
            res2={{1{src0[31]}},src0[31:1]};
        end 
        5'd2:begin
            res1={2'b0,src0[31:2]};
            res2={{2{src0[31]}},src0[31:2]};
        end 
        5'd3:begin
            res1={3'b0,src0[31:3]};
            res2={{3{src0[31]}},src0[31:3]};
        end 
        5'd4:begin
            res1={4'b0,src0[31:4]};
            res2={{4{src0[31]}},src0[31:4]};
        end 
        5'd5:begin
            res1={5'b0,src0[31:5]};
            res2={{5{src0[31]}},src0[31:5]};
        end 
        5'd6:begin
            res1={6'b0,src0[31:6]};
            res2={{6{src0[31]}},src0[31:6]};
        end 
        5'd7:begin
            res1={7'b0,src0[31:7]};
            res2={{7{src0[31]}},src0[31:7]};
        end 
    endcase

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
