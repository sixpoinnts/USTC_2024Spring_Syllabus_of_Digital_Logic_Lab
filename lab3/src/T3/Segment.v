module Segment(
    input                       clk,
    input                       rst,
    input       [31:0]          output_data,

    output reg  [ 3:0]          seg_data,
    output reg  [ 2:0]          seg_an
);

//计数器
reg [31:0] counter;
parameter   MAX_VALUE = 32'd250_000;
always @(posedge clk) begin
    if (rst)
        counter <= 0;
    else begin
        if (counter >= MAX_VALUE)
            counter <= 0;
        else
            counter <= counter + 32'b1;
    end
end

//Update seg_id
reg [2:0] seg_id;
initial 
    seg_id<=3'b000;

always @(posedge clk) begin
    if(counter==0) begin
        if(seg_id==3'b111)
            seg_id<=3'b000;
        else
            seg_id<=seg_id+1;
    end
    else 
        seg_id<=seg_id;
end

// Update seg_data according to seg_id. Hint: Use "case".
wire [31:0] output_data;
always @(*) begin
    seg_data = 0;
    seg_an = seg_id;    // <- Same for all cases

    case(seg_an) 
        3'b000: seg_data<=output_data[3:0];
        3'b001: seg_data<=output_data[7:4];
        3'b010: seg_data<=output_data[11:8];
        3'b011: seg_data<=output_data[15:12];
        3'b100: seg_data<=output_data[19:16];
        3'b101: seg_data<=output_data[23:20];
        3'b110: seg_data<=output_data[27:24];
        3'b111: seg_data<=output_data[31:28];
    endcase   
end

endmodule
