module TIMER (
    input                           clk, rst,
    output           [3:0]       out,
    output           [2:0]       select
);

reg [3:0] outh;
reg [3:0] outms;
reg [3:0] outmg;
reg [3:0] outss;
reg [3:0] outsg;
reg [39:0] count;

initial begin
    outh    = 4'h1;
    outms   = 4'h2;
    outmg   = 4'h3;
    outss   = 4'h4;
    outsg   = 4'h5;
    count   = 40'h0;
end

always @(posedge clk) begin
    if(rst) begin
        count<=40'h1;
    end
    else begin
        if (count != 40'd100_000_000) //1s
            count <= count +40'h1;
        else
            count <=40'h1;
    end
end

/*使用 Lab3 实验练习中编写的数码管显示模块*/
Segment segment(
    .clk                (clk),
    .rst                (rst),
    .output_data        ({12'b0, outh, outms, outmg, outss,outsg}),
    .output_valid       (8'HFF),     
    .seg_data           (out),
    .seg_an             (select)
);

always@ (posedge clk) begin
    if(rst) begin
        outh    <=  4'H1;
        outms   <=  4'H2;
        outmg   <=  4'H3;
        outss   <=  4'H4;
        outsg   <=  4'H5;
    end
    else begin
        if(count == 40'd100_000_000) begin
            if(outsg != 4'h9)
                outsg <= outsg+1;
            else begin
                outsg <= 4'h0;
                if(outss != 4'h5)
                    outss <= outss + 1;
                else begin
                    outss <= 4'h0;
                    if(outmg != 4'h9)
                        outmg <= outmg + 1;
                    else begin
                        outmg <= 4'h0;
                        if(outms != 4'h5)
                            outms <= outms +1;
                        else begin
                            outms <= 4'b0;
                            if(outh != 4'h9)
                                outh <=outh+1;
                            else
                                outh <=0;
                        end
                    end
                end
            end
        end
    end
end

endmodule