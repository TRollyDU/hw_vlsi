module dlatch (
    input d,
    input en,
    input rst,
    output reg q
);

    always @(*) begin
        if (rst) q = 1'b0;
        else if (en) q = d;
    end

endmodule
