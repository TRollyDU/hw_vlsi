`timescale 1ns/1ps
module tb_jkff;
reg clk = 0;
reg rst=0,j=0,k=0,ref_q;
wire q;
integer i = 0, pass = 0, fail = 0;
always #5 clk = ~clk;
jkff dut(.clk(clk), .rst(rst), .j(j), .k(k), .q(q));
task check;
    input ok;
    begin
        if (ok === 1'b1) begin pass = pass + 1; $display("PASS jkff test=%0d time=%0t", i, $time); end
        else begin fail = fail + 1; $display("FAIL jkff test=%0d time=%0t", i, $time); end
    end
endtask

initial begin
    #1; rst=1; #1; check(q === 0); ref_q=0;
    for (i=0; i<8; i=i+1) begin
        @(negedge clk); rst=0;
        case (i)
            0,4: {j,k}=2'b10;
            1,5: {j,k}=2'b00;
            2,6: {j,k}=2'b11;
            3,7: {j,k}=2'b01;
        endcase
        ref_q=(j & ~ref_q) | (~k & ref_q);
        @(posedge clk); #1; check(q === ref_q);
    end
    #1; rst=1; #1; check(q === 0);
    $display("SUMMARY jkff PASS=%0d FAIL=%0d", pass, fail);
    $finish;
end
endmodule
