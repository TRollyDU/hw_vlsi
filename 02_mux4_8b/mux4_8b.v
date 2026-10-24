module mux4_8b(input [7:0] d0, d1, d2, d3, input [1:0] sel,
    output reg [7:0] y);
always @* begin
    case (sel)
        0: y=d0;
        1: y=d1;
        2: y=d2;
        3: y=d3;
        default: y=0;
    endcase
end
endmodule
