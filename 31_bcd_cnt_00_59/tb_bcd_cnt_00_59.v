`timescale 1ns/1ps
module tb_bcd_cnt_00_59;
reg clk = 0;
reg rst=0,tick=0;
integer seconds=0;
wire [3:0] tens,ones;
integer i = 0, pass = 0, fail = 0;
always #5 clk = ~clk;
bcd_cnt_00_59 dut(.clk(clk), .rst(rst), .tick(tick), .tens(tens), .ones(ones));
task check;
    input ok;
    begin
        if (ok === 1'b1) begin pass = pass + 1; $display("PASS bcd_cnt_00_59 test=%0d time=%0t", i, $time); end
        else begin fail = fail + 1; $display("FAIL bcd_cnt_00_59 test=%0d time=%0t", i, $time); end
    end
endtask

initial begin
    #1; rst=1; #1; check({tens,ones} === 8'h00);
    for (i=0; i<72; i=i+1) begin
        @(negedge clk); rst=0; tick=(i!=9 && i!=10 && i!=61 && i!=62);
        if (tick) seconds=(seconds+1)%60;
        @(posedge clk); #1;
        check((tens === (seconds/10)) && (ones === (seconds%10)));
    end
    #1; rst=1; #1; check({tens,ones} === 8'h00);
    @(negedge clk); rst=0; tick=1;
    @(posedge clk); #1; check({tens,ones} === 8'h01);
    $display("SUMMARY bcd_cnt_00_59 PASS=%0d FAIL=%0d", pass, fail);
    $finish;
end
endmodule
