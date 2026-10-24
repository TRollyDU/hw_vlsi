`timescale 1ns/1ps
module tb_univ_shift4;
reg clk = 0;
reg rst=0,sl=0,sr=0;
reg [1:0] mode=0;
reg [3:0] d=0,ref_q=0;
wire [3:0] q;
integer i = 0, pass = 0, fail = 0;
always #5 clk = ~clk;
univ_shift4 dut(.clk(clk), .rst(rst), .mode(mode), .d(d), .sl(sl), .sr(sr), .q(q));
task check;
    input ok;
    begin
        if (ok === 1'b1) begin pass = pass + 1; $display("PASS univ_shift4 test=%0d time=%0t", i, $time); end
        else begin fail = fail + 1; $display("FAIL univ_shift4 test=%0d time=%0t", i, $time); end
    end
endtask

initial begin
    #1; rst=1; #1; check(q === 0);
    for (i=0; i<16; i=i+1) begin
        @(negedge clk); rst=0; mode=(i+3)%4; d=(i<8)?10:5;
        sl=(i/4)%2; sr=~sl;
        case(mode)
            1:ref_q=ref_q/2+8*sr;
            2:ref_q=ref_q*2+sl;
            3:ref_q=d;
        endcase
        @(posedge clk); #1; check(q === ref_q);
    end
    #1; mode=3; rst=1; #1; check(q === 0);
    $display("SUMMARY univ_shift4 PASS=%0d FAIL=%0d", pass, fail);
    $finish;
end
endmodule
