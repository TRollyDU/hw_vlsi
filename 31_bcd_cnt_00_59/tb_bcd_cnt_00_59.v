`timescale 1ns/1ps

module tb_bcd_cnt_00_59;

    reg clk = 1'b0;
    reg rst = 1'b0;
    reg tick = 1'b0;
    integer seconds = 32'sd0;
    wire [3:0] tens;
    wire [3:0] ones;
    integer i = 32'sd0;
    integer pass = 32'sd0;
    integer fail = 32'sd0;

    always #10
        clk = ~clk;

    bcd_cnt_00_59 dut (
        .clk(clk),
        .rst(rst),
        .tick(tick),
        .tens(tens),
        .ones(ones)
    );

    task check;
        input ok;
        begin
            if (ok === 1'b1) begin
                pass = pass + 32'sd1;
                $display("PASS bcd_cnt_00_59 test=%0d time=%0t", i, $time);
            end
            else begin
                fail = fail + 32'sd1;
                $display("FAIL bcd_cnt_00_59 test=%0d time=%0t", i, $time);
            end
        end
    endtask

    initial begin
        #1;
        rst = 1'b1;
        #1;
        check({tens, ones} === 8'h00);
        for (i = 32'sd0; i < 32'sd72; i = i + 32'sd1) begin
            @(negedge clk);
            rst = 1'b0;
            tick = (i != 32'sd9 && i != 32'sd10 && i != 32'sd61 && i != 32'sd62);
            if (tick) seconds = (seconds + 32'sd1) % 32'sd60;
            @(posedge clk);
            #1;
            check((tens === (seconds / 32'sd10)) && (ones === (seconds % 32'sd10)));
        end
        #1;
        rst = 1'b1;
        #1;
        check({tens, ones} === 8'h00);
        @(negedge clk);
        rst = 1'b0;
        tick = 1'b1;
        @(posedge clk);
        #1;
        check({tens, ones} === 8'h01);
        $display("SUMMARY bcd_cnt_00_59 PASS=%0d FAIL=%0d", pass, fail);
        $finish;
    end

endmodule
