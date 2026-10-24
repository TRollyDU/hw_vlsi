module barrel8(input [7:0] d, input [2:0] shamt, input right, output [7:0] y);
assign y = right ? ((d >> shamt) | (d << (8-shamt)))
                 : ((d << shamt) | (d >> (8-shamt)));
endmodule
