module mul4x4 (
    input [3:0] a,
    input [3:0] b,
    output [7:0] product
);

    wire [7:0] pp0;
    wire [7:0] pp1;
    wire [7:0] pp2;
    wire [7:0] pp3;

    assign pp0 = b[0] ? {4'b0000, a} : 8'd0;
    assign pp1 = b[1] ? ({4'b0000, a} << 3'd1) : 8'd0;
    assign pp2 = b[2] ? ({4'b0000, a} << 3'd2) : 8'd0;
    assign pp3 = b[3] ? ({4'b0000, a} << 3'd3) : 8'd0;
    assign product = pp0 + pp1 + pp2 + pp3;

endmodule
