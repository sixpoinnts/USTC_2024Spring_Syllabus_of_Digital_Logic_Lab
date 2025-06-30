module Counter #(
    parameter   MAX_VALUE = 8'd100,
    parameter   MIN_VALUE = 8'd001
)(
    input                   clk,
    input                   rst,
    input                   enable,
    output                  out
);

reg [7:0] counter;

always @(posedge clk) begin
    if (rst==1'b1)
        counter <=0;
    else begin
        if(enable==1'b0) 
            counter <= 0;
        else begin
            if ((counter >= MAX_VALUE)||(counter < MIN_VALUE))
                counter <= MIN_VALUE;
            else
                counter <= counter + 8'd1;    
        end
    end
end

assign out = (counter == MAX_VALUE);
endmodule