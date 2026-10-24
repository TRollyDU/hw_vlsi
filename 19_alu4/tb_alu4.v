`timescale 1ns/1ps

module tb_alu4;

    reg [3:0] a;
    reg [3:0] b;
    reg [3:0] ref_y;
    reg [2:0] op;
    reg ref_flag;
    integer value;
    wire [3:0] y;
    wire carry_borrow;
    wire zero;
    integer i = 32'sd0;
    integer pass = 32'sd0;
    integer fail = 32'sd0;

    alu4 dut (
        .a(a),
        .b(b),
        .op(op),
        .y(y),
        .carry_borrow(carry_borrow),
        .zero(zero)
    );

    task check;
        input ok;
        begin
            if (ok === 1'b1) begin
                pass = pass + 32'sd1;
                $display("PASS alu4 test=%0d", i);
            end
            else begin
                fail = fail + 32'sd1;
                $display("FAIL alu4 test=%0d", i);
            end
        end
    endtask

    initial begin
        for (i = 32'sd0; i < 32'sd32; i = i + 32'sd1) begin
            op = i % 32'sd8;
            case (i / 32'sd8)
                32'sd0: {a, b} = 8'h00;
                32'sd1: {a, b} = 8'hf1;
                32'sd2: {a, b} = 8'h5a;
                32'sd3: {a, b} = 8'h88;
            endcase
            ref_flag = 1'b0;
            value = 32'sd0;
            case (op)
                3'd0: begin
                    value = a + b;
                    ref_flag = (value > 32'sd15);
                end
                3'd1: begin
                    value = a - b;
                    ref_flag = (a < b);
                end
                3'd2: value = a & b;
                3'd3: value = a | b;
                3'd4: value = a ^ b;
                3'd5: value = 32'sd15 - a;
                3'd6: value = a * 4'd2;
                3'd7: value = a / 4'd2;
            endcase
            ref_y = value;
            #1;
            check(y === ref_y && carry_borrow === ref_flag && zero === (ref_y == 4'd0));
        end
        $display("SUMMARY alu4 PASS=%0d FAIL=%0d", pass, fail);
        $finish;
    end

endmodule
