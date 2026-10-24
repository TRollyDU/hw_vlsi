module cnt_up4_load (
    input clk,
    input rst,
    input en,
    input load,
    input [3:0] d,
    output reg [3:0] q
);

    always @(posedge clk or posedge rst) begin
        if (rst) q <= 4'd0;
        else if (load) q <= d;
        else if (en) q <= q + 4'd1;
    end

endmodule
