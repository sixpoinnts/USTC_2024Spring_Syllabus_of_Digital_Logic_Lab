module Regfile (
    input                       clk,          // 时钟信号
    input           [4:0]       ra1,          // 读端口 1 地址
    input           [4:0]       ra2,          // 读端口 2 地址
    input           [4:0]       wa,           // 写端口地址
    input                       we,           // 写使能信号
    input           [31:0]      din,          // 写数据
    output  reg     [31:0]      dout1,        // 读端口 1 数据输出
    output  reg     [31:0]      dout2         // 读端口 2 数据输出
);
// 寄存器堆的规模为 32x32bits
reg [31:0] reg_file [31:0];

// 0 号寄存器始终保持 0
always @(*) begin
    reg_file[0]=32'b0;
end

// 读端口 1
always @(*) begin
    if(we&&(wa==ra1)&&(wa!=0))
        dout1=din;
    else
        dout1 = reg_file[ra1];
end

// 读端口 2
always @(*) begin
    if(we&&(wa==ra2)&&(wa!=0))
        dout2=din;
    else
        dout2 = reg_file[ra2];
end
    
// 写端口
always @(posedge clk) begin
    if (we) begin
        if(wa)
            reg_file[wa] <= din;
    end
end

endmodule