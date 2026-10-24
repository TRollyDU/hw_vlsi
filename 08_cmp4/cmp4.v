module cmp4(input [3:0] a, b, output gt, eq, lt);
assign gt = a > b;
assign eq = a == b;
assign lt = a < b;
endmodule
