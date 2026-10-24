`timescale 1ns/1ps

module tb_sub4;

    reg [3:0] a;
    reg [3:0] b;
    reg bin;
    integer delta;
    wire [3:0] diff;
    wire bout;
    integer i = 32'sd0;
    integer pass = 32'sd0;
    integer fail = 32'sd0;

    sub4 dut (
        .a(a),
        .b(b),
        .bin(bin),
        .diff(diff),
        .bout(bout)
    );

    task check;
        input ok;
        begin
            if (ok === 1'b1) begin
                pass = pass + 32'sd1;
                $display("PASS sub4 test=%0d", i);
            end
            else begin
                fail = fail + 32'sd1;
                $display("FAIL sub4 test=%0d", i);
            end
        end
    endtask

    initial begin
        for (i = 32'sd0; i < 32'sd512; i = i + 32'sd1) begin
            {a, b, bin} = i;
            delta = a - b - bin;
            #1;
            check((diff === (delta & 32'sd15)) && (bout === (delta < 32'sd0)));
        end
        $display("SUMMARY sub4 PASS=%0d FAIL=%0d", pass, fail);
        $finish;
    end

endmodule
