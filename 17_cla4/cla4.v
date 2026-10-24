module cla4(input [3:0] a, b, input cin, output [3:0] sum, output cout);
wire [3:0] p, g;
wire [4:0] c;
assign p = a ^ b;
assign g = a & b;
assign c[0] = cin;
assign c[1] = g[0] | (p[0]&cin);
assign c[2] = g[1] | (p[1]&g[0]) | (p[1]&p[0]&cin);
assign c[3] = g[2] | (p[2]&g[1]) | (p[2]&p[1]&g[0]) | (p[2]&p[1]&p[0]&cin);
assign c[4] = g[3] | (p[3]&g[2]) | (p[3]&p[2]&g[1])
            | (p[3]&p[2]&p[1]&g[0]) | (p[3]&p[2]&p[1]&p[0]&cin);
assign sum = p ^ c[3:0];
assign cout = c[4];
endmodule
