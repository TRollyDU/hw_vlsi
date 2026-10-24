`timescale 1ns/1ps

module tb_cnt_updn4;

    reg clk = 1'b0;
    reg rst = 1'b0;
    reg en = 1'b0;
    reg up = 1'b0;
    reg [3:0] ref_q = 4'd0;
    wire [3:0] q;
    integer i = 32'sd0;
    integer pass = 32'sd0;
    integer fail = 32'sd0;

    always #10
        clk = ~clk;

    cnt_updn4 dut (
        .clk(clk),
        .rst(rst),
        .en(en),
        .up(up),
        .q(q)
    );

    task check;
        input ok;
        begin
            if (ok === 1'b1) begin
                pass = pass + 32'sd1;
                $display("PASS cnt_updn4 test=%0d time=%0t", i, $time);
            end
            else begin
                fail = fail + 32'sd1;
                $display("FAIL cnt_updn4 test=%0d time=%0t", i, $time);
            end
        end
    endtask

    initial begin
        #1;
        rst = 1'b1;
        #1;
        check(q === 4'd0);
        for (i = 32'sd0; i < 32'sd42; i = i + 32'sd1) begin
            @(negedge clk);
            rst = 1'b0;
            up = (i >= 32'sd18);
            en = (i != 32'sd2 && i != 32'sd22);
            if (en) ref_q = up ? ref_q + 1'b1 : ref_q - 1'b1;
            @(posedge clk);
            #1;
            check(q === ref_q);
        end
        #1;
        rst = 1'b1;
        #1;
        check(q === 4'd0);
        $display("SUMMARY cnt_updn4 PASS=%0d FAIL=%0d", pass, fail);
        $finish;
    end

endmodule
