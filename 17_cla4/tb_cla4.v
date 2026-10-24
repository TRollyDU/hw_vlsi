`timescale 1ns/1ps

module tb_cla4;

    reg [3:0] a;
    reg [3:0] b;
    reg cin;
    reg [4:0] ref_sum;
    wire [3:0] sum;
    wire cout;
    integer i = 32'sd0;
    integer pass = 32'sd0;
    integer fail = 32'sd0;

    cla4 dut (
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );

    task check;
        input ok;
        begin
            if (ok === 1'b1) begin
                pass = pass + 32'sd1;
                $display("PASS cla4 test=%0d", i);
            end
            else begin
                fail = fail + 32'sd1;
                $display("FAIL cla4 test=%0d", i);
            end
        end
    endtask

    initial begin
        for (i = 32'sd0; i < 32'sd512; i = i + 32'sd1) begin
            {a, b, cin} = i;
            ref_sum = {1'b0, a} + {1'b0, b} + cin;
            #1;
            check({cout, sum} === ref_sum);
        end
        $display("SUMMARY cla4 PASS=%0d FAIL=%0d", pass, fail);
        $finish;
    end

endmodule
