module bin_gray (
    input [3:0] bin_in,
    input [3:0] gray_in,
    output [3:0] gray_out,
    output [3:0] bin_out
);

    assign gray_out = bin_in ^ (bin_in >> 4'd1);
    assign bin_out = {gray_in[3], ^ gray_in[3:2], ^ gray_in[3:1], ^ gray_in[3:0]};

endmodule
