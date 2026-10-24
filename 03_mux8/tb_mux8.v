`timescale 1ns/1ps
module tb_mux8;
reg [7:0] d;
reg [2:0] sel;
wire y;
integer i = 0, pass = 0, fail = 0;
mux8 dut(.d(d), .sel(sel), .y(y));
task check;
    input ok;
    begin
        if (ok === 1'b1) begin pass = pass + 1; $display("PASS mux8 test=%0d", i); end
        else begin fail = fail + 1; $display("FAIL mux8 test=%0d", i); end
    end
endtask
initial begin

    for (i=0; i<2048; i=i+1) begin
        {d,sel}=i; #1; check(y === ((d >> sel) & 1'b1));
    end
    $display("SUMMARY mux8 PASS=%0d FAIL=%0d", pass, fail);
    $finish;
end
endmodule
