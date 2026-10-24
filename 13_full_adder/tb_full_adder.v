`timescale 1ns/1ps
module tb_full_adder;
reg a,b,cin;
wire sum,cout;
integer i = 0, pass = 0, fail = 0;
full_adder dut(.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));
task check;
    input ok;
    begin
        if (ok === 1'b1) begin pass = pass + 1; $display("PASS full_adder test=%0d", i); end
        else begin fail = fail + 1; $display("FAIL full_adder test=%0d", i); end
    end
endtask
initial begin

    for (i=0; i<8; i=i+1) begin
        {a,b,cin}=i; #1;
        check({cout,sum} === ({1'b0,a}+{1'b0,b}+{1'b0,cin}));
    end
    $display("SUMMARY full_adder PASS=%0d FAIL=%0d", pass, fail);
    $finish;
end
endmodule
