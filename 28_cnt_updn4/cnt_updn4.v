module cnt_updn4(input clk, rst, en, up, output reg [3:0] q);
always @(posedge clk or posedge rst) begin
    if (rst) q<=0;
    else if (en) q<=up ? q+1'b1 : q-1'b1;
end
endmodule
