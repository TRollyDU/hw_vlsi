`timescale 1ns/1ps
module tb_dff_rst;
reg clk = 0;
reg rst=0,d=0;
wire qs,qa;
integer i = 0, pass = 0, fail = 0;
always #5 clk = ~clk;
dff_rst dut(.clk(clk), .rst(rst), .d(d), .q_sync(qs), .q_async(qa));
task check;
    input ok;
    begin
        if (ok === 1'b1) begin pass = pass + 1; $display("PASS dff_rst test=%0d time=%0t", i, $time); end
        else begin fail = fail + 1; $display("FAIL dff_rst test=%0d time=%0t", i, $time); end
    end
endtask

initial begin
    #1; rst=1; #1; check(qa === 0);
    @(posedge clk); #1; check({qs,qa} === 2'b00);
    @(negedge clk); rst=0; d=1;
    @(posedge clk); #1; check({qs,qa} === 2'b11);
    #1; rst=1; #1; check({qs,qa} === 2'b10);
    @(posedge clk); #1; check({qs,qa} === 2'b00);
    @(negedge clk); rst=0; d=1;
    @(posedge clk); #1; check({qs,qa} === 2'b11);
    #1; d=0; #1; check({qs,qa} === 2'b11);
    @(posedge clk); #1; check({qs,qa} === 2'b00);
    $display("SUMMARY dff_rst PASS=%0d FAIL=%0d", pass, fail);
    $finish;
end
endmodule
