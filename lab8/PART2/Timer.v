module Timer(
    input                   [ 0 : 0]            clk,
    input                   [ 0 : 0]            rst,

    input                   [ 0 : 0]            set,
    input                   [ 0 : 0]            en,

    output                  [ 7 : 0]            minute,
    output                  [ 7 : 0]            second,
    output                  [11 : 0]            micro_second,

    output                  [ 0 : 0]            finish
);

reg current_state, next_state;
localparam ON = 1;
localparam OFF = 0;

always @(posedge clk) begin
    if (rst)
        current_state <= OFF;
    else
        current_state <= next_state;
end

// TODO: Finish the FSM
always @(*) begin
    next_state = current_state;

    case (current_state)
            OFF: begin
                if(en) begin   
                    next_state = ON;
                end
            end
            ON: begin
                if((~en||finish)==0) begin
                    next_state = OFF;
                end
            end       
    endcase
end

localparam TIME_1MS = 100_000_000 / 1000;
reg [31 : 0] counter;
// TODO: Finish the counter
always @(posedge clk) begin
    if (rst) begin
        counter <= 0;
    end
    else begin
        if(current_state==ON) begin
            if (counter >= TIME_1MS) begin
                counter <= 0;
            end
            else
                counter <= counter + 32'd1;
        end
    end
end

wire carry_in[2:0];
Clock # (
    .WIDTH                  (8)    ,
    .MIN_VALUE              (0)    ,
    .MAX_VALUE              (59)   ,
    .SET_VALUE              (1)      
) minute_clock (
    .clk                    (clk),
    .rst                    (rst),
    .set                    (set),
    .carry_in               (carry_in[2]),
    .carry_out              (finish),
    .value                  (minute)
);
Clock # (
    .WIDTH                  (8)   ,
    .MIN_VALUE              (0)   ,
    .MAX_VALUE              (59)  ,
    .SET_VALUE              (0)      
) second_clock (
    .clk                    (clk),
    .rst                    (rst),
    .set                    (set),
    .carry_in               (carry_in[1]),
    .carry_out              (carry_in[2]),
    .value                  (second)
);
Clock # (
    .WIDTH                  (12)   ,
    .MIN_VALUE              (0)    ,
    .MAX_VALUE              (999)  ,
    .SET_VALUE              (0)      
) micro_second_clock (
    .clk                    (clk),
    .rst                    (rst),
    .set                    (set),
    .carry_in               (carry_in[0]),
    .carry_out              (carry_in[1]),
    .value                  (micro_second)
);
// TODO: what's carry_in[0] ?
assign carry_in[0] = (counter==TIME_1MS);

endmodule
