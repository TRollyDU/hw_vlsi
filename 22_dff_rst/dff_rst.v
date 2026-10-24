module dff_rst (
    input clk,
    input rst,
    input d,
    output reg q_sync,
    output reg q_async
);

    always @(posedge clk) begin
        if (rst) q_sync <= 1'b0;
        else q_sync <= d;
    end

    always @(posedge clk or posedge rst) begin
        if (rst) q_async <= 1'b0;
        else q_async <= d;
    end

endmodule
