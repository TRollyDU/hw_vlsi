module bin_gray(input [3:0] bin_in, gray_in, output [3:0] gray_out, bin_out);
assign gray_out = bin_in ^ (bin_in >> 1);
assign bin_out = {gray_in[3], ^gray_in[3:2], ^gray_in[3:1], ^gray_in[3:0]};
endmodule
