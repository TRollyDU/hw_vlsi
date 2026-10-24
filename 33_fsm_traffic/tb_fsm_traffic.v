`timescale 1ns/1ps
module tb_fsm_traffic;
reg clk = 0;
reg rst=0,tick=0,ref_green=0;
wire red,green;
integer i = 0, pass = 0, fail = 0;
always #5 clk = ~clk;
fsm_traffic dut(.clk(clk), .rst(rst), .tick(tick), .red(red), .green(green));
task check;
    input ok;
    begin
        if (ok === 1'b1) begin pass = pass + 1; $display("PASS fsm_traffic test=%0d time=%0t", i, $time); end
        else begin fail = fail + 1; $display("FAIL fsm_traffic test=%0d time=%0t", i, $time); end
    end
endtask

initial begin
    #1; rst=1; #1; check({red,green} === 2'b10);
    for (i=0; i<12; i=i+1) begin
        @(negedge clk); rst=0; tick=(i==0 || i==3 || i>=6);
        if (tick) ref_green=~ref_green;
        @(posedge clk); #1; check({red,green} === {~ref_green,ref_green});
    end
    @(negedge clk); tick=1;
    @(posedge clk); #1; check({red,green} === 2'b01);
    #1; rst=1; #1; check({red,green} === 2'b10);
    @(posedge clk); #1; check({red,green} === 2'b10);
    $display("SUMMARY fsm_traffic PASS=%0d FAIL=%0d", pass, fail);
    $finish;
end
endmodule
