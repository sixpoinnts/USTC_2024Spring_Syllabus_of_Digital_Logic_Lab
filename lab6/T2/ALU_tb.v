module ALU_tb();
reg     [31:0]      src0,src1;
reg     [11:0]      sel;
wire    [31:0]      res;

initial begin
    src0=32'habc1; src1=32'hfff2; sel=12'h001;
    repeat(11) begin
        #30 sel = sel << 1;
    end
end
    
ALU alu(
    .src0(src0),
    .src1(src1),
    .sel(sel),
    .res(res)
);
endmodule
