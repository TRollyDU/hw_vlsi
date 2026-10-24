module lfsr8 #(
    parameter [7:0] SEED = 8'h01
) (
    input clk,
    input rst,
    input en,
    output reg [7:0] q
);

    always @(posedge clk or posedge rst) begin
        if (rst) q <= SEED;
        else if (en) q <= {q[6:0], q[7] ^ q[5] ^ q[4] ^ q[3]};
    end

endmodule
