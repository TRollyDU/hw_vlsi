module cnt_updn4 (
    input clk,
    input rst,
    input en,
    input up,
    output reg [3:0] q
);

    always @(posedge clk or posedge rst) begin
        if (rst) q <= 4'd0;
        else if (en) q <= up ? q + 4'd1 : q - 4'd1;
    end

endmodule
