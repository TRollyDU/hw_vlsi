module fsm_traffic(input clk, rst, tick, output red, green);
localparam RED=1'b0, GREEN=1'b1;
reg state;
always @(posedge clk or posedge rst) begin
    if (rst) state<=RED;
    else if (tick) state<=~state;
end
assign red = (state==RED);
assign green = (state==GREEN);
endmodule
