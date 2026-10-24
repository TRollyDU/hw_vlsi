`timescale 1ns/1ps
module tb_mux4_8b;
reg [7:0] d0,d1,d2,d3,ref_y;
reg [1:0] sel;
wire [7:0] y;
integer i = 0, pass = 0, fail = 0;
mux4_8b dut(.d0(d0), .d1(d1), .d2(d2), .d3(d3), .sel(sel), .y(y));
task check;
    input ok;
    begin
        if (ok === 1'b1) begin pass = pass + 1; $display("PASS mux4_8b test=%0d", i); end
        else begin fail = fail + 1; $display("FAIL mux4_8b test=%0d", i); end
    end
endtask
initial begin

    for (i=0; i<20; i=i+1) begin
        sel=i%4; d0=$random; d1=$random; d2=$random; d3=$random;
        if (i<4) begin d0=0; d1=255; d2=85; d3=170; end
        case(sel) 0:ref_y=d0; 1:ref_y=d1; 2:ref_y=d2; 3:ref_y=d3; endcase
        #1; check(y === ref_y);
    end
    $display("SUMMARY mux4_8b PASS=%0d FAIL=%0d", pass, fail);
    $finish;
end
endmodule
