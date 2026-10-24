module prio_enc4_2 (
    input [3:0] d,
    output reg [1:0] code,
    output valid
);

    assign valid = | d;

    always @(*) begin
        if (d[3]) code = 2'd3;
        else if (d[2]) code = 2'd2;
        else if (d[1]) code = 2'd1;
        else code = 2'd0;
    end

endmodule
