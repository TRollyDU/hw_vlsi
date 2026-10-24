`timescale 1ns/1ps
module tb_dlatch;
reg d,en,rst;
wire q;
integer i = 0, pass = 0, fail = 0;
dlatch dut(.d(d), .en(en), .rst(rst), .q(q));
task check;
    input ok;
    begin
        if (ok === 1'b1) begin pass = pass + 1; $display("PASS dlatch test=%0d", i); end
        else begin fail = fail + 1; $display("FAIL dlatch test=%0d", i); end
    end
endtask
initial begin
    d=1; en=0; rst=1; #1; check(q === 0);
    rst=0; en=1; d=1; #1; check(q === 1);
    d=0; #1; check(q === 0);
    d=1; #1; check(q === 1);
    en=0; d=0; #1; check(q === 1);
    rst=1; #1; check(q === 0);
    rst=0; d=1; #1; check(q === 0);
    en=1; #1; check(q === 1);
    rst=1; #1; check(q === 0);
    $display("SUMMARY dlatch PASS=%0d FAIL=%0d", pass, fail);
    $finish;
end
endmodule
