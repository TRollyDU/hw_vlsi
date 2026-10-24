`timescale 1ns/1ps
module tb_lfsr8;
reg clk = 0;
reg rst=0,en=0;
reg [255:0] seen=0;
reg [7:0] first [0:7];
wire [7:0] q;
integer i = 0, pass = 0, fail = 0;
always #5 clk = ~clk;
lfsr8 dut(.clk(clk), .rst(rst), .en(en), .q(q));
task check;
    input ok;
    begin
        if (ok === 1'b1) begin pass = pass + 1; $display("PASS lfsr8 test=%0d time=%0t", i, $time); end
        else begin fail = fail + 1; $display("FAIL lfsr8 test=%0d time=%0t", i, $time); end
    end
endtask

initial begin
    first[0]=2; first[1]=4; first[2]=8; first[3]=17;
    first[4]=35; first[5]=71; first[6]=142; first[7]=28;
    #1; rst=1; #1; check(q === 8'h01);
    for (i=0; i<255; i=i+1) begin
        @(negedge clk); rst=0; en=1;
        @(posedge clk); #1; check(q!=0 && !seen[q]);
        if (i<8) check(q === first[i]);
        seen[q]=1;
    end
    check(q === 8'h01);
    @(negedge clk); en=0;
    repeat (3) begin @(posedge clk); #1; check(q === 8'h01); end
    #1; rst=1; #1; check(q === 8'h01);
    $display("SUMMARY lfsr8 PASS=%0d FAIL=%0d", pass, fail);
    $finish;
end
endmodule
