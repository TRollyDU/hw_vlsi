`timescale 1ns/1ps

module tb_sipo8;

    reg clk = 1'b0;
    reg rst = 1'b0;
    reg en = 1'b0;
    reg serial_in = 1'b0;
    reg [7:0] ref_q = 8'd0;
    reg [7:0] pattern = 8'ha5;
    integer k = 32'sd7;
    wire [7:0] q;
    integer i = 32'sd0;
    integer pass = 32'sd0;
    integer fail = 32'sd0;

    always #10
        clk = ~clk;

    sipo8 dut (
        .clk(clk),
        .rst(rst),
        .en(en),
        .serial_in(serial_in),
        .q(q)
    );

    task check;
        input ok;
        begin
            if (ok === 1'b1) begin
                pass = pass + 32'sd1;
                $display("PASS sipo8 test=%0d time=%0t", i, $time);
            end
            else begin
                fail = fail + 32'sd1;
                $display("FAIL sipo8 test=%0d time=%0t", i, $time);
            end
        end
    endtask

    initial begin
        #1;
        rst = 1'b1;
        #1;
        check(q === 8'd0);
        for (i = 32'sd0; i < 32'sd10; i = i + 32'sd1) begin
            @(negedge clk);
            rst = 1'b0;
            en = (i != 32'sd3 && i != 32'sd6);
            serial_in = pattern[k];
            if (en) begin
                ref_q = ref_q * 8'd2 + serial_in;
                k = k - 32'sd1;
            end
            @(posedge clk);
            #1;
            check(q === ref_q);
        end
        check(q === pattern);
        #1;
        rst = 1'b1;
        #1;
        check(q === 8'd0);
        $display("SUMMARY sipo8 PASS=%0d FAIL=%0d", pass, fail);
        $finish;
    end

endmodule
