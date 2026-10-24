module prio_enc8_3(input [7:0] d, output reg [2:0] code, output valid);
integer k;
assign valid = |d;
always @* begin
    code=0;
    for (k=0; k<8; k=k+1)
        if (d[k]) code=k;
end
endmodule
