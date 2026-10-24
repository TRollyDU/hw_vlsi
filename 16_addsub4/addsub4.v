module addsub4 (
    input [3:0] a,
    input [3:0] b,
    input sub,
    output [3:0] result,
    output carry_borrow
);

    assign {carry_borrow, result} = sub ? ({1'b0, a} - {1'b0, b}) : ({1'b0, a} + {1'b0, b});

endmodule
