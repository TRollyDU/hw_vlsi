`timescale 1ns/1ps
module tb_bcd_7seg;
reg [3:0] bcd;
reg [6:0] ref_seg [0:15];
wire [6:0] seg;
integer i = 0, pass = 0, fail = 0;
bcd_7seg dut(.bcd(bcd), .seg(seg));
task check;
    input ok;
    begin
        if (ok === 1'b1) begin pass = pass + 1; $display("PASS bcd_7seg test=%0d", i); end
        else begin fail = fail + 1; $display("FAIL bcd_7seg test=%0d", i); end
    end
endtask
initial begin
    ref_seg[0]=126; ref_seg[1]=48; ref_seg[2]=109; ref_seg[3]=121;
    ref_seg[4]=51; ref_seg[5]=91; ref_seg[6]=95; ref_seg[7]=112;
    ref_seg[8]=127; ref_seg[9]=123;
    for (i=10; i<16; i=i+1) ref_seg[i]=0;
    for (i=0; i<16; i=i+1) begin
        bcd=i; #1; check(seg === ref_seg[i]);
    end
    $display("SUMMARY bcd_7seg PASS=%0d FAIL=%0d", pass, fail);
    $finish;
end
endmodule
