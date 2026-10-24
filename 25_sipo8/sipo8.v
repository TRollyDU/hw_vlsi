module sipo8(input clk, rst, en, serial_in, output reg [7:0] q);
always @(posedge clk or posedge rst) begin
    if (rst) q<=0;
    else if (en) q<={q[6:0],serial_in};
end
endmodule
