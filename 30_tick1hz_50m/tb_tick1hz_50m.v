`timescale 1ns/1ps
module tb_tick1hz_50m;
reg clk = 0;
reg rst=0;
integer cycles=0;
wire tick,one;
integer i = 0, pass = 0, fail = 0;
always #5 clk = ~clk;
tick1hz_50m #(.CLOCK_HZ(5)) dut(.clk(clk), .rst(rst), .tick(tick));
task check;
    input ok;
    begin
        if (ok === 1'b1) begin pass = pass + 1; $display("PASS tick1hz_50m test=%0d time=%0t", i, $time); end
        else begin fail = fail + 1; $display("FAIL tick1hz_50m test=%0d time=%0t", i, $time); end
    end
endtask
tick1hz_50m #(.CLOCK_HZ(1)) edge_dut(.clk(clk), .rst(rst), .tick(one));
initial begin
    #1; rst=1; #1; check({tick,one} === 2'b00);
    for (i=0; i<24; i=i+1) begin
        @(negedge clk); rst=0;
        if (i==7) begin
            rst=1; cycles=0; #1; check({tick,one} === 2'b00);
            #1; rst=0;
        end
        cycles=cycles+1;
        @(posedge clk); #1; check((tick === (cycles%5==0)) && (one === 1'b1));
    end
    $display("SUMMARY tick1hz_50m PASS=%0d FAIL=%0d", pass, fail);
    $finish;
end
endmodule
