module alu4(input [3:0] a, b, input [2:0] op,
    output reg [3:0] y, output reg carry_borrow, output zero);
always @* begin
    y=0; carry_borrow=0;
    case (op)
        0: {carry_borrow,y}={1'b0,a}+{1'b0,b};
        1: {carry_borrow,y}={1'b0,a}-{1'b0,b};
        2: y=a&b;
        3: y=a|b;
        4: y=a^b;
        5: y=~a;
        6: y=a<<1;
        7: y=a>>1;
        default: y=0;
    endcase
end
assign zero = (y==0);
endmodule
