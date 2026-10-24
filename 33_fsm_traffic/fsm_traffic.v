module fsm_traffic (
    input clk,
    input rst,
    input tick,
    output red,
    output green
);

    localparam RED = 1'b0;
    localparam GREEN = 1'b1;
    reg state;

    always @(posedge clk or posedge rst) begin
        if (rst) state <= RED;
        else if (tick) state <= ~state;
    end
    assign red = (state == RED);
    assign green = (state == GREEN);

endmodule
