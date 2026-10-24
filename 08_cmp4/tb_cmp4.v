`timescale 1ns/1ps
module tb_cmp4;
reg [3:0] a,b;
wire gt,eq,lt;
integer i = 0, pass = 0, fail = 0;
cmp4 dut(.a(a), .b(b), .gt(gt), .eq(eq), .lt(lt));
task check;
    input ok;
    begin
        if (ok === 1'b1) begin pass = pass + 1; $display("PASS cmp4 test=%0d", i); end
        else begin fail = fail + 1; $display("FAIL cmp4 test=%0d", i); end
    end
endtask
initial begin

    for (i=0; i<256; i=i+1) begin
        {a,b}=i; #1; check({gt,eq,lt} === {(a>b),(a==b),(a<b)});
    end
    $display("SUMMARY cmp4 PASS=%0d FAIL=%0d", pass, fail);
    $finish;
end
endmodule
