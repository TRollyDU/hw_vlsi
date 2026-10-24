`timescale 1ns/1ps

module tb_dlatch;

    reg d;
    reg en;
    reg rst;
    wire q;
    integer i = 32'sd0;
    integer pass = 32'sd0;
    integer fail = 32'sd0;

    dlatch dut (
        .d(d),
        .en(en),
        .rst(rst),
        .q(q)
    );

    task check;
        input ok;
        begin
            if (ok === 1'b1) begin
                pass = pass + 32'sd1;
                $display("PASS dlatch test=%0d", i);
            end
            else begin
                fail = fail + 32'sd1;
                $display("FAIL dlatch test=%0d", i);
            end
        end
    endtask

    initial begin
        d = 1'b1;
        en = 1'b0;
        rst = 1'b1;
        #1;
        check(q === 1'b0);
        rst = 1'b0;
        en = 1'b1;
        d = 1'b1;
        #1;
        check(q === 1'b1);
        d = 1'b0;
        #1;
        check(q === 1'b0);
        d = 1'b1;
        #1;
        check(q === 1'b1);
        en = 1'b0;
        d = 1'b0;
        #1;
        check(q === 1'b1);
        rst = 1'b1;
        #1;
        check(q === 1'b0);
        rst = 1'b0;
        d = 1'b1;
        #1;
        check(q === 1'b0);
        en = 1'b1;
        #1;
        check(q === 1'b1);
        rst = 1'b1;
        #1;
        check(q === 1'b0);
        $display("SUMMARY dlatch PASS=%0d FAIL=%0d", pass, fail);
        $finish;
    end

endmodule
