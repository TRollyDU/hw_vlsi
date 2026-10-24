module sync_ram16x8(input clk, en, we, input [3:0] addr,
    input [7:0] din, output reg [7:0] dout);
reg [7:0] mem [0:15];
always @(posedge clk) begin
    if (en) begin
        if (we) begin mem[addr]<=din; dout<=din; end
        else dout<=mem[addr];
    end
end
endmodule
