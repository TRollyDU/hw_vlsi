`timescale 1ns/1ps
module tb_sipo8;
reg clk = 0;
reg rst=0,en=0,serial_in=0;
reg [7:0] ref_q=0,pattern=8'ha5;
integer k=7;
wire [7:0] q;
integer i = 0, pass = 0, fail = 0;
always #5 clk = ~clk;
sipo8 dut(.clk(clk), .rst(rst), .en(en), .serial_in(serial_in), .q(q));
task check;
    input ok;
    begin
        if (ok === 1'b1) begin pass = pass + 1; $display("PASS sipo8 test=%0d time=%0t", i, $time); end
        else begin fail = fail + 1; $display("FAIL sipo8 test=%0d time=%0t", i, $time); end
    end
endtask

initial begin
    #1; rst=1; #1; check(q === 0);
    for (i=0; i<10; i=i+1) begin
        @(negedge clk); rst=0; en=(i!=3 && i!=6); serial_in=pattern[k];
        if (en) begin ref_q=ref_q*2+serial_in; k=k-1; end
        @(posedge clk); #1; check(q === ref_q);
    end
    check(q === pattern);
    #1; rst=1; #1; check(q === 0);
    $display("SUMMARY sipo8 PASS=%0d FAIL=%0d", pass, fail);
    $finish;
end
endmodule
