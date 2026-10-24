module dff_rst(input clk, rst, d, output reg q_sync, q_async);
always @(posedge clk) begin
    if (rst) q_sync<=0;
    else q_sync<=d;
end
always @(posedge clk or posedge rst) begin
    if (rst) q_async<=0;
    else q_async<=d;
end
endmodule
