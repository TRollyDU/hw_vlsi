module clk_div #(parameter integer HALF_PERIOD=2)
    (input clk, rst, output reg clk_out);
integer count;
always @(posedge clk or posedge rst) begin
    if (rst) begin count<=0; clk_out<=0; end
    else if (count==HALF_PERIOD-1) begin count<=0; clk_out<=~clk_out; end
    else count<=count+1;
end
endmodule
