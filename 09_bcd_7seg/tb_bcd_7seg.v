`timescale 1ns/1ps

module tb_bcd_7seg;

    reg [3:0] bcd;
    reg [6:0] ref_seg[0:15];
    wire [6:0] seg;
    integer i = 32'sd0;
    integer pass = 32'sd0;
    integer fail = 32'sd0;

    bcd_7seg dut (
        .bcd(bcd),
        .seg(seg)
    );

    task check;
        input ok;
        begin
            if (ok === 1'b1) begin
                pass = pass + 32'sd1;
                $display("PASS bcd_7seg test=%0d", i);
            end
            else begin
                fail = fail + 32'sd1;
                $display("FAIL bcd_7seg test=%0d", i);
            end
        end
    endtask

    initial begin
        ref_seg[0] = 7'd126;
        ref_seg[1] = 7'd48;
        ref_seg[2] = 7'd109;
        ref_seg[3] = 7'd121;
        ref_seg[4] = 7'd51;
        ref_seg[5] = 7'd91;
        ref_seg[6] = 7'd95;
        ref_seg[7] = 7'd112;
        ref_seg[8] = 7'd127;
        ref_seg[9] = 7'd123;
        for (i = 32'sd10; i < 32'sd16; i = i + 32'sd1)
            ref_seg[i] = 7'd0;
        for (i = 32'sd0; i < 32'sd16; i = i + 32'sd1) begin
            bcd = i;
            #1;
            check(seg === ref_seg[i]);
        end
        $display("SUMMARY bcd_7seg PASS=%0d FAIL=%0d", pass, fail);
        $finish;
    end

endmodule
