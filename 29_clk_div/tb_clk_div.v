`timescale 1ns/1ps

module tb_clk_div;

    reg clk = 1'b0;
    reg rst = 1'b0;
    integer cycles = 32'sd0;
    wire slow;
    wire fast;
    integer i = 32'sd0;
    integer pass = 32'sd0;
    integer fail = 32'sd0;

    always #10
        clk = ~clk;

    clk_div #(
        .HALF_PERIOD(26'd3)
    ) dut (
        .clk(clk),
        .rst(rst),
        .clk_out(slow)
    );

    task check;
        input ok;
        begin
            if (ok === 1'b1) begin
                pass = pass + 32'sd1;
                $display("PASS clk_div test=%0d time=%0t", i, $time);
            end
            else begin
                fail = fail + 32'sd1;
                $display("FAIL clk_div test=%0d time=%0t", i, $time);
            end
        end
    endtask

    clk_div #(
        .HALF_PERIOD(26'd1)
    ) edge_dut (
        .clk(clk),
        .rst(rst),
        .clk_out(fast)
    );

    initial begin
        #1;
        rst = 1'b1;
        #1;
        check({slow, fast} === 2'b00);
        for (i = 32'sd0; i < 32'sd22; i = i + 32'sd1) begin
            @(negedge clk);
            rst = 1'b0;
            if (i == 32'sd8) begin
                rst = 1'b1;
                cycles = 32'sd0;
                #1;
                check({slow, fast} === 2'b00);
                #1;
                rst = 1'b0;
            end
            cycles = cycles + 32'sd1;
            @(posedge clk);
            #1;
            check((slow === ((cycles / 32'sd3) % 32'sd2 != 32'sd0)) && (fast === (cycles % 32'sd2 != 32'sd0)));
        end
        $display("SUMMARY clk_div PASS=%0d FAIL=%0d", pass, fail);
        $finish;
    end

endmodule
