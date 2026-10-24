module dff_en(input clk, rst, en, d, output reg q);
always @(posedge clk or posedge rst) begin
    if (rst) q<=0;
    else if (en) q<=d;
end
endmodule
