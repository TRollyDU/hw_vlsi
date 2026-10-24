module clk_div #(
    parameter [25:0] HALF_PERIOD = 26'd2
) (
    input clk,
    input rst,
    output reg clk_out
);

    reg [25:0] count;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            count <= 26'd0;
            clk_out <= 1'b0;
        end
        else if (count == HALF_PERIOD - 26'd1) begin
            count <= 26'd0;
            clk_out <= ~clk_out;
        end
        else count <= count + 26'd1;
    end

endmodule
