module Seg_vaild(
    input                   clk,
    input                   rst,
    input           [7:0]   second,
    output  reg     [7:0]   output_vaild
);
reg [31:0] count;
parameter   TIME_1HS = 50_000_000;
parameter   TIME_2HS = 25_000_000;

always @(posedge clk) begin
    if(rst)
        count <= 0;
    else 
        if(count >= TIME_1HS) begin
            count <= 0;
            if(second > 8'd3 && second < 8'd10)
                output_vaild <= ~ output_vaild;
            else
                output_vaild <= 8'b1111_1111;
        end
        else begin
            count <= count + 1;
            if(count == TIME_2HS && second >8'd0 && second < 8'd3)
                output_vaild <= ~output_vaild;
        end
end


endmodule