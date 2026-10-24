module prio_enc8_3 (
    input [7:0] d,
    output reg [2:0] code,
    output valid
);

    assign valid = | d;

    always @(*) begin
        if (d[7]) code = 3'd7;
        else if (d[6]) code = 3'd6;
        else if (d[5]) code = 3'd5;
        else if (d[4]) code = 3'd4;
        else if (d[3]) code = 3'd3;
        else if (d[2]) code = 3'd2;
        else if (d[1]) code = 3'd1;
        else code = 3'd0;
    end

endmodule
