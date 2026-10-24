`timescale 1ns/1ps

module tb_fsm_traffic;

    reg clk = 1'b0;
    reg rst = 1'b0;
    reg tick = 1'b0;
    reg ref_green = 1'b0;
    wire red;
    wire green;
    integer i = 32'sd0;
    integer pass = 32'sd0;
    integer fail = 32'sd0;

    always #10
        clk = ~clk;

    fsm_traffic dut (
        .clk(clk),
        .rst(rst),
        .tick(tick),
        .red(red),
        .green(green)
    );

    task check;
        input ok;
        begin
            if (ok === 1'b1) begin
                pass = pass + 32'sd1;
                $display("PASS fsm_traffic test=%0d time=%0t", i, $time);
            end
            else begin
                fail = fail + 32'sd1;
                $display("FAIL fsm_traffic test=%0d time=%0t", i, $time);
            end
        end
    endtask

    initial begin
        #1;
        rst = 1'b1;
        #1;
        check({red, green} === 2'b10);
        for (i = 32'sd0; i < 32'sd12; i = i + 32'sd1) begin
            @(negedge clk);
            rst = 1'b0;
            tick = (i == 32'sd0 || i == 32'sd3 || i >= 32'sd6);
            if (tick) ref_green = ~ref_green;
            @(posedge clk);
            #1;
            check({red, green} === {~ref_green, ref_green});
        end
        @(negedge clk);
        tick = 1'b1;
        @(posedge clk);
        #1;
        check({red, green} === 2'b01);
        #1;
        rst = 1'b1;
        #1;
        check({red, green} === 2'b10);
        @(posedge clk);
        #1;
        check({red, green} === 2'b10);
        $display("SUMMARY fsm_traffic PASS=%0d FAIL=%0d", pass, fail);
        $finish;
    end

endmodule
