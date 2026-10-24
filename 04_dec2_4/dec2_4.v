module dec2_4(input [1:0] a, output [3:0] y);
assign y = 4'b1 << a;
endmodule
