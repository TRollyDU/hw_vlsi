module sipo8 (
    input clk,
    input rst,
    input en,
    input serial_in,
    output reg [7:0] q
);

    always @(posedge clk or posedge rst) begin
        if (rst) q <= 8'd0;
        else if (en) q <= {q[6:0], serial_in};
    end

endmodule
