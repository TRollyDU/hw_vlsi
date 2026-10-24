`timescale 1ns/1ps
module tb_sub4;
reg [3:0] a,b;
reg bin;
integer delta;
wire [3:0] diff;
wire bout;
integer i = 0, pass = 0, fail = 0;
sub4 dut(.a(a), .b(b), .bin(bin), .diff(diff), .bout(bout));
task check;
    input ok;
    begin
        if (ok === 1'b1) begin pass = pass + 1; $display("PASS sub4 test=%0d", i); end
        else begin fail = fail + 1; $display("FAIL sub4 test=%0d", i); end
    end
endtask
initial begin

    for (i=0; i<512; i=i+1) begin
        {a,b,bin}=i; delta=a-b-bin;
        #1; check((diff === (delta & 15)) && (bout === (delta<0)));
    end
    $display("SUMMARY sub4 PASS=%0d FAIL=%0d", pass, fail);
    $finish;
end
endmodule
