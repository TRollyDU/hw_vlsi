`timescale 1ns/1ps
module tb_cnt_up4_load;
reg clk = 0;
reg rst=0,en=0,load=0;
reg [3:0] d=0,ref_q=0;
wire [3:0] q;
integer i = 0, pass = 0, fail = 0;
always #5 clk = ~clk;
cnt_up4_load dut(.clk(clk), .rst(rst), .en(en), .load(load), .d(d), .q(q));
task check;
    input ok;
    begin
        if (ok === 1'b1) begin pass = pass + 1; $display("PASS cnt_up4_load test=%0d time=%0t", i, $time); end
        else begin fail = fail + 1; $display("FAIL cnt_up4_load test=%0d time=%0t", i, $time); end
    end
endtask

initial begin
    #1; rst=1; #1; check(q === 0);
    for (i=0; i<24; i=i+1) begin
        @(negedge clk); rst=0; load=(i==0 || i==4); en=(i!=0 && i!=2);
        d=(i==0)?14:15;
        if (load) ref_q=d; else if (en) ref_q=ref_q+1'b1;
        @(posedge clk); #1; check(q === ref_q);
    end
    #1; load=1; en=1; rst=1; #1; check(q === 0);
    @(posedge clk); #1; check(q === 0);
    $display("SUMMARY cnt_up4_load PASS=%0d FAIL=%0d", pass, fail);
    $finish;
end
endmodule
