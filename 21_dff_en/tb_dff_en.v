`timescale 1ns/1ps

module tb_dff_en;

    reg clk = 1'b0;
    reg rst = 1'b0;
    reg en = 1'b0;
    reg d = 1'b0;
    reg ref_q;
    wire q;
    integer i = 32'sd0;
    integer pass = 32'sd0;
    integer fail = 32'sd0;

    always #10
        clk = ~clk;

    dff_en dut (
        .clk(clk),
        .rst(rst),
        .en(en),
        .d(d),
        .q(q)
    );

    task check;
        input ok;
        begin
            if (ok === 1'b1) begin
                pass = pass + 32'sd1;
                $display("PASS dff_en test=%0d time=%0t", i, $time);
            end
            else begin
                fail = fail + 32'sd1;
                $display("FAIL dff_en test=%0d time=%0t", i, $time);
            end
        end
    endtask

    initial begin
        #1;
        rst = 1'b1;
        #1;
        check(q === 1'b0);
        ref_q = 1'b0;
        for (i = 32'sd0; i < 32'sd8; i = i + 32'sd1) begin
            @(negedge clk);
            rst = 1'b0;
            {en, d} = i % 32'sd4;
            if (en) ref_q = d;
            @(posedge clk);
            #1;
            check(q === ref_q);
        end
        #1;
        rst = 1'b1;
        #1;
        check(q === 1'b0);
        $display("SUMMARY dff_en PASS=%0d FAIL=%0d", pass, fail);
        $finish;
    end

endmodule
