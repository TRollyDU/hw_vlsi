`timescale 1ns/1ps

module tb_univ_shift4;

    reg clk = 1'b0;
    reg rst = 1'b0;
    reg sl = 1'b0;
    reg sr = 1'b0;
    reg [1:0] mode = 2'd0;
    reg [3:0] d = 4'd0;
    reg [3:0] ref_q = 4'd0;
    wire [3:0] q;
    integer i = 32'sd0;
    integer pass = 32'sd0;
    integer fail = 32'sd0;

    always #10
        clk = ~clk;

    univ_shift4 dut (
        .clk(clk),
        .rst(rst),
        .mode(mode),
        .d(d),
        .sl(sl),
        .sr(sr),
        .q(q)
    );

    task check;
        input ok;
        begin
            if (ok === 1'b1) begin
                pass = pass + 32'sd1;
                $display("PASS univ_shift4 test=%0d time=%0t", i, $time);
            end
            else begin
                fail = fail + 32'sd1;
                $display("FAIL univ_shift4 test=%0d time=%0t", i, $time);
            end
        end
    endtask

    initial begin
        #1;
        rst = 1'b1;
        #1;
        check(q === 4'd0);
        for (i = 32'sd0; i < 32'sd16; i = i + 32'sd1) begin
            @(negedge clk);
            rst = 1'b0;
            mode = (i + 32'sd3) % 3'd4;
            d = (i < 32'sd8) ? 4'd10 : 4'd5;
            sl = (i / 32'sd4) % 2'd2;
            sr = ~sl;
            case (mode)
                2'd1: ref_q = ref_q / 4'd2 + 4'd8 * sr;
                2'd2: ref_q = ref_q * 4'd2 + sl;
                2'd3: ref_q = d;
            endcase
            @(posedge clk);
            #1;
            check(q === ref_q);
        end
        #1;
        mode = 2'd3;
        rst = 1'b1;
        #1;
        check(q === 4'd0);
        $display("SUMMARY univ_shift4 PASS=%0d FAIL=%0d", pass, fail);
        $finish;
    end

endmodule
