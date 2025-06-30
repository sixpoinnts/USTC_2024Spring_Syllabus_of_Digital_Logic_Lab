module Adder_LookAhead4 (
    input                   [ 3 : 0]            a, b,
    input                   [ 0 : 0]            ci,         // 来自低位的进位
    output                  [ 3 : 0]            s,          // 和
    output                  [ 0 : 0]            co          // 向高位的进位
);

wire    [3:0] C;
wire    [3:0] G;
wire    [3:0] P;

assign  G = a & b;
assign  P = a ^ b;

assign  C[0] = G[0] | ( P[0] & ci );
assign  C[1] = G[1] | ( P[1] & G[0] ) | ( P[1] & P[0] & ci );
assign  C[2] = G[2] | ( P[2] & G[1] ) | ( P[2] & P[1] & G[0] ) | ( P[2] & P[1] & P[0] & ci );
assign  C[3] = G[3] | ( P[3] & G[2] ) | ( P[3] & P[2] & G[1] ) | ( P[3] & P[2] & P[1] & G[0] ) | ( P[3] & P[2] & P[1] & P[0] & ci );

// TODO：确定 s 和 co 的产生逻辑
assign  s[0] = P[0] ^ ci;
assign  s[1] = P[1] ^ C[0];
assign  s[2] = P[2] ^ C[1];
assign  s[3] = P[3] ^ C[2];
assign  co   = C[3];

endmodule
