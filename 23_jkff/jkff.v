module jkff (
    input clk,
    input rst,
    input j,
    input k,
    output reg q
);

    always @(posedge clk or posedge rst) begin
        if (rst) q <= 1'b0;
        else
            case ({j, k})
                2'b00: q <= q;
                2'b01: q <= 1'b0;
                2'b10: q <= 1'b1;
                2'b11: q <= ~q;
            endcase
    end

endmodule
