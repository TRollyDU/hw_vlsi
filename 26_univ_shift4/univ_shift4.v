module univ_shift4 (
    input clk,
    input rst,
    input [1:0] mode,
    input [3:0] d,
    input sl,
    input sr,
    output reg [3:0] q
);

    always @(posedge clk or posedge rst) begin
        if (rst) q <= 4'd0;
        else
            case (mode)
                2'd0: q <= q;
                2'd1: q <= {sr, q[3:1]};
                2'd2: q <= {q[2:0], sl};
                2'd3: q <= d;
            endcase
    end

endmodule
