module multiple5(
    input           [7:0]          num,
    output   reg                   ismultiple5
);
// Write your code here
// Use the 2-bits adder, or you will not get the score! [1:0] sum_odd,sum_even;
wire [2:0] sum_odd,sum_even;

adder2bit odd(
    .a(num[1:0]),
    .b(num[5:4]),
    .out(sum_odd[1:0]),
    .Cout(sum_odd[2])
);
adder2bit even(
    .a(num[3:2]),
    .b(num[7:6]),
    .out(sum_even[1:0]),
    .Cout(sum_even[2])
);

always @(*) begin
    if(sum_odd[2]==sum_even[2]) begin
        if(sum_odd[1]==sum_even[1]&&sum_odd[0]==sum_even[0])
            ismultiple5<=1;
        else
            ismultiple5<=0;
            
    end
    else begin
        case(sum_odd)
            3'b110: 
                if(sum_even==3'b001)
                    ismultiple5<=1;
                else ismultiple5<=0;
            3'b101: 
                if(sum_even==3'b000)
                    ismultiple5<=1;
                else ismultiple5<=0;
            3'b001: 
                if(sum_even==3'b110)
                    ismultiple5<=1;
                else ismultiple5<=0;
            3'b000: 
                if(sum_even==3'b101)
                    ismultiple5<=1;
                else ismultiple5<=0;
            default: ismultiple5<=0;
        endcase
    end
end
// End of your code
endmodule