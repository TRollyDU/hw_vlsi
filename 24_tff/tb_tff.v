`timescale 1ns/1ps

module tb_tff;

    reg clk = 1'b0;
    reg rst = 1'b0;
    reg t = 1'b0;
    reg ref_q;
    wire q;
    integer i = 32'sd0;
    integer pass = 32'sd0;
    integer fail = 32'sd0;

    always #10
        clk = ~clk;

    tff dut (
        .clk(clk),
        .rst(rst),
        .t(t),
        .q(q)
    );

    task check;
        input ok;
        begin
            if (ok === 1'b1) begin
                pass = pass + 32'sd1;
                $display("PASS tff test=%0d time=%0t", i, $time);
            end
            else begin
                fail = fail + 32'sd1;
                $display("FAIL tff test=%0d time=%0t", i, $time);
            end
        end
    endtask

    initial begin
        #1;
        rst = 1'b1;
        #1;
        check(q === 1'b0);
        ref_q = 1'b0;
        for (i = 32'sd0; i < 32'sd10; i = i + 32'sd1) begin
            @(negedge clk);
            rst = 1'b0;
            t = (i % 32'sd3 != 1'b0);
            if (t) ref_q = ~ref_q;
            @(posedge clk);
            #1;
            check(q === ref_q);
        end
        #1;
        rst = 1'b1;
        #1;
        check(q === 1'b0);
        $display("SUMMARY tff PASS=%0d FAIL=%0d", pass, fail);
        $finish;
    end

endmodule
