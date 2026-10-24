module dlatch(input d, en, rst, output reg q);
always @* begin
    if (rst) q=0;
    else if (en) q=d;
end
endmodule
