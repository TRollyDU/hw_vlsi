`timescale 1ns/1ps
module tb_sync_ram16x8;
reg clk = 0;
reg en=0,we=0;
reg [3:0] addr=0;
reg [7:0] din=0,ref_data;
wire [7:0] dout;
integer i = 0, pass = 0, fail = 0;
always #5 clk = ~clk;
sync_ram16x8 dut(.clk(clk), .en(en), .we(we), .addr(addr), .din(din), .dout(dout));
task check;
    input ok;
    begin
        if (ok === 1'b1) begin pass = pass + 1; $display("PASS sync_ram16x8 test=%0d time=%0t", i, $time); end
        else begin fail = fail + 1; $display("FAIL sync_ram16x8 test=%0d time=%0t", i, $time); end
    end
endtask

initial begin

    for (i=0; i<16; i=i+1) begin
        @(negedge clk); en=1; we=1; addr=i; din=i*13+7;
        @(posedge clk); #1; check(dout === din);
    end
    for (i=0; i<16; i=i+1) begin
        @(negedge clk); we=0; addr=15-i; ref_data=(15-i)*13+7;
        @(posedge clk); #1; check(dout === ref_data);
    end
    #1; addr=15; #1; check(dout === 8'd7);
    @(negedge clk); en=0; we=1; addr=0; din=255;
    @(posedge clk); #1; check(dout === 8'd7);
    @(negedge clk); en=1; we=0;
    @(posedge clk); #1; check(dout === 8'd7);
    @(negedge clk); we=1; din=8'ha5;
    @(posedge clk); #1; check(dout === 8'ha5);
    @(negedge clk); we=0; din=0;
    @(posedge clk); #1; check(dout === 8'ha5);
    $display("SUMMARY sync_ram16x8 PASS=%0d FAIL=%0d", pass, fail);
    $finish;
end
endmodule
