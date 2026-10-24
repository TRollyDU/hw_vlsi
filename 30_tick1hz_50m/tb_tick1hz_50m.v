`timescale 1ns/1ps

module tb_tick1hz_50m;

    reg clk = 1'b0;
    reg rst = 1'b0;
    integer cycles = 32'sd0;
    wire tick;
    wire one;
    integer i = 32'sd0;
    integer pass = 32'sd0;
    integer fail = 32'sd0;

    always #10
        clk = ~clk;

    tick1hz_50m #(
        .CLOCK_HZ(26'd5)
    ) dut (
        .clk(clk),
        .rst(rst),
        .tick(tick)
    );

    task check;
        input ok;
        begin
            if (ok === 1'b1) begin
                pass = pass + 32'sd1;
                $display("PASS tick1hz_50m test=%0d time=%0t", i, $time);
            end
            else begin
                fail = fail + 32'sd1;
                $display("FAIL tick1hz_50m test=%0d time=%0t", i, $time);
            end
        end
    endtask

    tick1hz_50m #(
        .CLOCK_HZ(26'd1)
    ) edge_dut (
        .clk(clk),
        .rst(rst),
        .tick(one)
    );

    initial begin
        #1;
        rst = 1'b1;
        #1;
        check({tick, one} === 2'b00);
        for (i = 32'sd0; i < 32'sd24; i = i + 32'sd1) begin
            @(negedge clk);
            rst = 1'b0;
            if (i == 32'sd7) begin
                rst = 1'b1;
                cycles = 32'sd0;
                #1;
                check({tick, one} === 2'b00);
                #1;
                rst = 1'b0;
            end
            cycles = cycles + 32'sd1;
            @(posedge clk);
            #1;
            check((tick === (cycles % 32'sd5 == 32'sd0)) && (one === 1'b1));
        end
        $display("SUMMARY tick1hz_50m PASS=%0d FAIL=%0d", pass, fail);
        $finish;
    end

endmodule
