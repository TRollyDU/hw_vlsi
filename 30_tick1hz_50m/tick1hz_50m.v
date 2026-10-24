module tick1hz_50m #(
    parameter [25:0] CLOCK_HZ = 26'd50000000
) (
    input clk,
    input rst,
    output reg tick
);

    reg [25:0] count;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            count <= 26'd0;
            tick <= 1'b0;
        end
        else if (count == CLOCK_HZ - 26'd1) begin
            count <= 26'd0;
            tick <= 1'b1;
        end
        else begin
            count <= count + 26'd1;
            tick <= 1'b0;
        end
    end

endmodule
