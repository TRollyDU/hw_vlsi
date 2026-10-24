`timescale 1ns/1ps

module tb_full_adder;

    reg a;
    reg b;
    reg cin;
    wire sum;
    wire cout;
    integer i = 32'sd0;
    integer pass = 32'sd0;
    integer fail = 32'sd0;

    full_adder dut (
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
                $display("PASS full_adder test=%0d", i);
            end
            else begin
                fail = fail + 32'sd1;
                $display("FAIL full_adder test=%0d", i);
            end
        end
    endtask

    initial begin
        for (i = 32'sd0; i < 32'sd8; i = i + 32'sd1) begin
            {a, b, cin} = i;
            #1;
            check({cout, sum} === ({1'b0, a} + {1'b0, b} + {1'b0, cin}));
        end
        $display("SUMMARY full_adder PASS=%0d FAIL=%0d", pass, fail);
        $finish;
    end

endmodule
