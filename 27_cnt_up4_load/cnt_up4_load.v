module cnt_up4_load(input clk, rst, en, load, input [3:0] d, output reg [3:0] q);
always @(posedge clk or posedge rst) begin
    if (rst) q<=0;
    else if (load) q<=d;
    else if (en) q<=q+1'b1;
end
endmodule
