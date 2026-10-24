`timescale 1ns/1ps
module tb_addsub4;
reg [3:0] a,b;
reg sub;
integer value;
reg flag;
wire [3:0] result;
wire carry_borrow;
integer i = 0, pass = 0, fail = 0;
addsub4 dut(.a(a), .b(b), .sub(sub), .result(result), .carry_borrow(carry_borrow));
task check;
    input ok;
    begin
        if (ok === 1'b1) begin pass = pass + 1; $display("PASS addsub4 test=%0d", i); end
        else begin fail = fail + 1; $display("FAIL addsub4 test=%0d", i); end
    end
endtask
initial begin

    for (i=0; i<512; i=i+1) begin
        {a,b,sub}=i; value=sub ? a-b : a+b;
        flag=sub ? a<b : value>15;
        #1; check(result === (value & 15) && carry_borrow === flag);
    end
    $display("SUMMARY addsub4 PASS=%0d FAIL=%0d", pass, fail);
    $finish;
end
endmodule
