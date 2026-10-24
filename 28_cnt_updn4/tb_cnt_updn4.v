`timescale 1ns/1ps
module tb_cnt_updn4;
reg clk = 0;
reg rst=0,en=0,up=0;
reg [3:0] ref_q=0;
wire [3:0] q;
integer i = 0, pass = 0, fail = 0;
always #5 clk = ~clk;
cnt_updn4 dut(.clk(clk), .rst(rst), .en(en), .up(up), .q(q));
task check;
    input ok;
    begin
        if (ok === 1'b1) begin pass = pass + 1; $display("PASS cnt_updn4 test=%0d time=%0t", i, $time); end
        else begin fail = fail + 1; $display("FAIL cnt_updn4 test=%0d time=%0t", i, $time); end
    end
endtask

initial begin
    #1; rst=1; #1; check(q === 0);
    for (i=0; i<42; i=i+1) begin
        @(negedge clk); rst=0; up=(i>=18); en=(i!=2 && i!=22);
        if (en) ref_q=up ? ref_q+1'b1 : ref_q-1'b1;
        @(posedge clk); #1; check(q === ref_q);
    end
    #1; rst=1; #1; check(q === 0);
    $display("SUMMARY cnt_updn4 PASS=%0d FAIL=%0d", pass, fail);
    $finish;
end
endmodule
