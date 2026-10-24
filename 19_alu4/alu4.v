module alu4 (
    input [3:0] a,
    input [3:0] b,
    input [2:0] op,
    output reg [3:0] y,
    output reg carry_borrow,
    output zero
);

    always @(*) begin
        y = 4'd0;
        carry_borrow = 1'b0;
        case (op)
            3'd0: {carry_borrow, y} = {1'b0, a} + {1'b0, b};
            3'd1: {carry_borrow, y} = {1'b0, a} - {1'b0, b};
            3'd2: {y} = a & b;
            3'd3: {y} = a | b;
            3'd4: {y} = a ^ b;
            3'd5: {y} = ~a;
            3'd6: {y} = a << 4'd1;
            3'd7: {y} = a >> 4'd1;
            default: y = 4'd0;
        endcase
    end
    assign zero = (y == 4'd0);

endmodule
