`timescale 1ns/1ps
module tb_tff;
reg clk = 0;
reg rst=0,t=0,ref_q;
wire q;
integer i = 0, pass = 0, fail = 0;
always #5 clk = ~clk;
tff dut(.clk(clk), .rst(rst), .t(t), .q(q));
task check;
    input ok;
    begin
        if (ok === 1'b1) begin pass = pass + 1; $display("PASS tff test=%0d time=%0t", i, $time); end
        else begin fail = fail + 1; $display("FAIL tff test=%0d time=%0t", i, $time); end
    end
endtask

initial begin
    #1; rst=1; #1; check(q === 0); ref_q=0;
    for (i=0; i<10; i=i+1) begin
        @(negedge clk); rst=0; t=(i%3!=0);
        if (t) ref_q=~ref_q;
        @(posedge clk); #1; check(q === ref_q);
    end
    #1; rst=1; #1; check(q === 0);
    $display("SUMMARY tff PASS=%0d FAIL=%0d", pass, fail);
    $finish;
end
endmodule
