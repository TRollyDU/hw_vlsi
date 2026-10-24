module rca4(input [3:0] a, b, input cin, output [3:0] sum, output cout);
wire [3:0] p, g;
wire [4:0] c;
assign p = a ^ b;
assign g = a & b;
assign c[0] = cin;
genvar k;
generate
    for (k=0; k<4; k=k+1) begin: stage
        assign c[k+1] = g[k] | (p[k] & c[k]);
    end
endgenerate
assign sum = p ^ c[3:0];
assign cout = c[4];
endmodule
