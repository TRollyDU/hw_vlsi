`timescale 1ns/1ps
module tb_logic;
reg a, b;
wire ya, yo, yx, yn, yr, ye, yt;
integer i = 0, pass = 0, fail = 0;
logic dut(.a(a), .b(b), .y_and(ya), .y_or(yo), .y_xor(yx), .y_nand(yn), .y_nor(yr), .y_xnor(ye), .y_not(yt));
task check;
    input ok;
    begin
        if (ok === 1'b1) begin pass = pass + 1; $display("PASS logic test=%0d", i); end
        else begin fail = fail + 1; $display("FAIL logic test=%0d", i); end
    end
endtask
initial begin

    for (i=0; i<4; i=i+1) begin
        {a,b}=i; #1;
        check({ya,yo,yx,yn,yr,ye,yt} ===
              {(a&&b),(a||b),(a!=b),!(a&&b),!(a||b),(a==b),!a});
    end
    $display("SUMMARY logic PASS=%0d FAIL=%0d", pass, fail);
    $finish;
end
endmodule
