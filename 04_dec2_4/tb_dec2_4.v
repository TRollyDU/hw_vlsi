`timescale 1ns/1ps

module tb_dec2_4;

    reg [1:0] a;
    wire [3:0] y;
    integer i = 32'sd0;
    integer pass = 32'sd0;
    integer fail = 32'sd0;

    dec2_4 dut (
        .a(a),
        .y(y)
    );

    task check;
        input ok;
        begin
            if (ok === 1'b1) begin
                pass = pass + 32'sd1;
                $display("PASS dec2_4 test=%0d", i);
            end
            else begin
                fail = fail + 32'sd1;
                $display("FAIL dec2_4 test=%0d", i);
            end
        end
    endtask

    initial begin
        for (i = 32'sd0; i < 32'sd4; i = i + 32'sd1) begin
            a = i;
            #1;
            check(y === (32'sd1 << i));
        end
        $display("SUMMARY dec2_4 PASS=%0d FAIL=%0d", pass, fail);
        $finish;
    end

endmodule
