`timescale 1ns/1ps

module tb_logic;

    reg a;
    reg b;
    wire ya;
    wire yo;
    wire yx;
    wire yn;
    wire yr;
    wire ye;
    wire yt;
    integer i = 32'sd0;
    integer pass = 32'sd0;
    integer fail = 32'sd0;

    logic dut (
        .a(a),
        .b(b),
        .y_and(ya),
        .y_or(yo),
        .y_xor(yx),
        .y_nand(yn),
        .y_nor(yr),
        .y_xnor(ye),
        .y_not(yt)
    );

    task check;
        input ok;
        begin
            if (ok === 1'b1) begin
                pass = pass + 32'sd1;
                $display("PASS logic test=%0d", i);
            end
            else begin
                fail = fail + 32'sd1;
                $display("FAIL logic test=%0d", i);
            end
        end
    endtask

    initial begin
        for (i = 32'sd0; i < 32'sd4; i = i + 32'sd1) begin
            {a, b} = i;
            #1;
            check({ya, yo, yx, yn, yr, ye, yt} === {(a && b), (a || b), (a != b), !(a && b), !(a || b), (a == b), !a});
        end
        $display("SUMMARY logic PASS=%0d FAIL=%0d", pass, fail);
        $finish;
    end

endmodule
