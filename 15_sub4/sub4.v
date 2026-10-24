module sub4(input [3:0] a, b, input bin, output [3:0] diff, output bout);
assign {bout,diff} = {1'b0,a} - {1'b0,b} - bin;
endmodule
