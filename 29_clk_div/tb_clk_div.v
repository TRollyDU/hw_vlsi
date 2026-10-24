`timescale 1ns/1ps
module tb_clk_div;
reg clk = 0;
reg rst=0;
integer cycles=0;
wire slow,fast;
integer i = 0, pass = 0, fail = 0;
always #5 clk = ~clk;
clk_div #(.HALF_PERIOD(3)) dut(.clk(clk), .rst(rst), .clk_out(slow));
task check;
    input ok;
    begin
        if (ok === 1'b1) begin pass = pass + 1; $display("PASS clk_div test=%0d time=%0t", i, $time); end
        else begin fail = fail + 1; $display("FAIL clk_div test=%0d time=%0t", i, $time); end
    end
endtask
clk_div #(.HALF_PERIOD(1)) edge_dut(.clk(clk), .rst(rst), .clk_out(fast));
initial begin
    #1; rst=1; #1; check({slow,fast} === 2'b00);
    for (i=0; i<22; i=i+1) begin
        @(negedge clk); rst=0;
        if (i==8) begin
            rst=1; cycles=0; #1; check({slow,fast} === 2'b00);
            #1; rst=0;
        end
        cycles=cycles+1;
        @(posedge clk); #1;
        check((slow === ((cycles/3)%2!=0)) && (fast === (cycles%2!=0)));
    end
    $display("SUMMARY clk_div PASS=%0d FAIL=%0d", pass, fail);
    $finish;
end
endmodule
