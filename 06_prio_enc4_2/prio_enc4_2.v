module prio_enc4_2(input [3:0] d, output reg [1:0] code, output valid);
integer k;
assign valid = |d;
always @* begin
    code=0;
    for (k=0; k<4; k=k+1)
        if (d[k]) code=k;
end
endmodule
