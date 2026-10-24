module bcd_cnt_00_59 (
    input clk,
    input rst,
    input tick,
    output reg [3:0] tens,
    output reg [3:0] ones
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            tens <= 4'd0;
            ones <= 4'd0;
        end
        else if (tick) begin
            if (ones == 4'd9) begin
                ones <= 4'd0;
                if (tens == 4'd5) tens <= 4'd0;
                else tens <= tens + 4'd1;
            end
            else ones <= ones + 4'd1;
        end
    end

endmodule
