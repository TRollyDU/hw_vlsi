`timescale 1ns/1ps
module tb_barrel8;
reg [7:0] d,ref_y;
reg [2:0] shamt;
reg right;
integer j,src;
wire [7:0] y;
integer i = 0, pass = 0, fail = 0;
barrel8 dut(.d(d), .shamt(shamt), .right(right), .y(y));
task check;
    input ok;
    begin
        if (ok === 1'b1) begin pass = pass + 1; $display("PASS barrel8 test=%0d", i); end
        else begin fail = fail + 1; $display("FAIL barrel8 test=%0d", i); end
    end
endtask
initial begin

    for (i=0; i<4096; i=i+1) begin
        {d,shamt,right}=i;
        for (j=0; j<8; j=j+1) begin
            src=right ? (j+shamt)%8 : (j+8-shamt)%8;
            ref_y[j]=d[src];
        end
        #1; check(y === ref_y);
    end
    $display("SUMMARY barrel8 PASS=%0d FAIL=%0d", pass, fail);
    $finish;
end
endmodule
