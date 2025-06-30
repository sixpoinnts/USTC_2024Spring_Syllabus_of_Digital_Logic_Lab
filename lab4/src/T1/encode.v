module encode(
    input [3:0]         I,
    output reg [1:0]    Y,
    output reg          en
);
// Write your codes here 
always @(*) begin
    if(I==4'b0000) 
        en <= 0;
    else begin
        en <= 1;
        case(I)
            4'b1000: Y = 2'b11;
            4'b0100: Y = 2'b10;
            4'b0010: Y = 2'b01;
            4'b0001: Y = 2'b00;
            default: Y = 2'b00;
        endcase
    end
end
// End of your codes
endmodule