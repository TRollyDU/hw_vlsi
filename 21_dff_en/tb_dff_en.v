`timescale 1ns/1ps
module tb_dff_en;
reg clk = 0;
reg rst=0,en=0,d=0,ref_q;
wire q;
integer i = 0, pass = 0, fail = 0;
always #5 clk = ~clk;
dff_en dut(.clk(clk), .rst(rst), .en(en), .d(d), .q(q));
task check;
    input ok;
    begin
        if (ok === 1'b1) begin pass = pass + 1; $display("PASS dff_en test=%0d time=%0t", i, $time); end
        else begin fail = fail + 1; $display("FAIL dff_en test=%0d time=%0t", i, $time); end
    end
endtask

initial begin
    #1; rst=1; #1; check(q === 0); ref_q=0;
    for (i=0; i<8; i=i+1) begin
        @(negedge clk); rst=0; {en,d}=i%4;
        if (en) ref_q=d;
        @(posedge clk); #1; check(q === ref_q);
    end
    #1; rst=1; #1; check(q === 0);
    $display("SUMMARY dff_en PASS=%0d FAIL=%0d", pass, fail);
    $finish;
end
endmodule
