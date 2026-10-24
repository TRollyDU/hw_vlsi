module univ_shift4(input clk, rst, input [1:0] mode,
    input [3:0] d, input sl, sr, output reg [3:0] q);
always @(posedge clk or posedge rst) begin
    if (rst) q<=0;
    else case (mode)
        0: q<=q;
        1: q<={sr,q[3:1]};
        2: q<={q[2:0],sl};
        3: q<=d;
    endcase
end
endmodule
