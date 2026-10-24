`timescale 1ns/1ps

module tb_cnt_up4_load;

    reg clk = 1'b0;
    reg rst = 1'b0;
    reg en = 1'b0;
    reg load = 1'b0;
    reg [3:0] d = 4'd0;
    reg [3:0] ref_q = 4'd0;
    wire [3:0] q;
    integer i = 32'sd0;
    integer pass = 32'sd0;
    integer fail = 32'sd0;

    always #10
        clk = ~clk;

    cnt_up4_load dut (
        .clk(clk),
        .rst(rst),
        .en(en),
        .load(load),
        .d(d),
        .q(q)
    );

    task check;
        input ok;
        begin
            if (ok === 1'b1) begin
                pass = pass + 32'sd1;
                $display("PASS cnt_up4_load test=%0d time=%0t", i, $time);
            end
            else begin
                fail = fail + 32'sd1;
                $display("FAIL cnt_up4_load test=%0d time=%0t", i, $time);
            end
        end
    endtask

    initial begin
        #1;
        rst = 1'b1;
        #1;
        check(q === 4'd0);
        for (i = 32'sd0; i < 32'sd24; i = i + 32'sd1) begin
            @(negedge clk);
            rst = 1'b0;
            load = (i == 32'sd0 || i == 32'sd4);
            en = (i != 32'sd0 && i != 32'sd2);
            d = (i == 32'sd0) ? 4'd14 : 4'd15;
            if (load) ref_q = d;
            else if (en) ref_q = ref_q + 1'b1;
            @(posedge clk);
            #1;
            check(q === ref_q);
        end
        #1;
        load = 1'b1;
        en = 1'b1;
        rst = 1'b1;
        #1;
        check(q === 4'd0);
        @(posedge clk);
        #1;
        check(q === 4'd0);
        $display("SUMMARY cnt_up4_load PASS=%0d FAIL=%0d", pass, fail);
        $finish;
    end

endmodule
