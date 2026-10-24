`timescale 1ns/1ps
module tb_fsm_1011;
reg clk = 0;
reg rst=0,din=0;
reg [39:0] stream=40'b1011011000010111110010101110101101101100;
reg [3:0] history=0;
integer count=0;
wire detect;
integer i = 0, pass = 0, fail = 0;
always #5 clk = ~clk;
fsm_1011 dut(.clk(clk), .rst(rst), .din(din), .detect(detect));
task check;
    input ok;
    begin
        if (ok === 1'b1) begin pass = pass + 1; $display("PASS fsm_1011 test=%0d time=%0t", i, $time); end
        else begin fail = fail + 1; $display("FAIL fsm_1011 test=%0d time=%0t", i, $time); end
    end
endtask

initial begin
    #1; rst=1; #1; check(detect === 0);
    for (i=0; i<40; i=i+1) begin
        @(negedge clk); rst=(i==12); din=stream[39-i];
        if (rst) begin history=0; count=0; #1; check(detect === 0); end
        else begin history={history[2:0],din}; count=count+1; end
        @(posedge clk); #1;
        check(detect === (!rst && count>=4 && history==4'b1011));
    end
    $display("SUMMARY fsm_1011 PASS=%0d FAIL=%0d", pass, fail);
    $finish;
end
endmodule
