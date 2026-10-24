`timescale 1ns/1ps

module tb_dff_rst;

    reg clk = 1'b0;
    reg rst = 1'b0;
    reg d = 1'b0;
    wire qs;
    wire qa;
    integer i = 32'sd0;
    integer pass = 32'sd0;
    integer fail = 32'sd0;

    always #10
        clk = ~clk;

    dff_rst dut (
        .clk(clk),
        .rst(rst),
        .d(d),
        .q_sync(qs),
        .q_async(qa)
    );

    task check;
        input ok;
        begin
            if (ok === 1'b1) begin
                pass = pass + 32'sd1;
                $display("PASS dff_rst test=%0d time=%0t", i, $time);
            end
            else begin
                fail = fail + 32'sd1;
                $display("FAIL dff_rst test=%0d time=%0t", i, $time);
            end
        end
    endtask

    initial begin
        #1;
        rst = 1'b1;
        #1;
        check(qa === 1'b0);
        @(posedge clk);
        #1;
        check({qs, qa} === 2'b00);
        @(negedge clk);
        rst = 1'b0;
        d = 1'b1;
        @(posedge clk);
        #1;
        check({qs, qa} === 2'b11);
        #1;
        rst = 1'b1;
        #1;
        check({qs, qa} === 2'b10);
        @(posedge clk);
        #1;
        check({qs, qa} === 2'b00);
        @(negedge clk);
        rst = 1'b0;
        d = 1'b1;
        @(posedge clk);
        #1;
        check({qs, qa} === 2'b11);
        #1;
        d = 1'b0;
        #1;
        check({qs, qa} === 2'b11);
        @(posedge clk);
        #1;
        check({qs, qa} === 2'b00);
        $display("SUMMARY dff_rst PASS=%0d FAIL=%0d", pass, fail);
        $finish;
    end

endmodule
