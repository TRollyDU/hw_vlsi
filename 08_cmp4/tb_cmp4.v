`timescale 1ns/1ps

module tb_cmp4;

    reg [3:0] a;
    reg [3:0] b;
    wire gt;
    wire eq;
    wire lt;
    integer i = 32'sd0;
    integer pass = 32'sd0;
    integer fail = 32'sd0;

    cmp4 dut (
        .a(a),
        .b(b),
        .gt(gt),
        .eq(eq),
        .lt(lt)
    );

    task check;
        input ok;
        begin
            if (ok === 1'b1) begin
                pass = pass + 32'sd1;
                $display("PASS cmp4 test=%0d", i);
            end
            else begin
                fail = fail + 32'sd1;
                $display("FAIL cmp4 test=%0d", i);
            end
        end
    endtask

    initial begin
        for (i = 32'sd0; i < 32'sd256; i = i + 32'sd1) begin
            {a, b} = i;
            #1;
            check({gt, eq, lt} === {(a > b), (a == b), (a < b)});
        end
        $display("SUMMARY cmp4 PASS=%0d FAIL=%0d", pass, fail);
        $finish;
    end

endmodule
