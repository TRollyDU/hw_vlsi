`timescale 1ns/1ps

module tb_half_adder;

    reg a;
    reg b;
    wire sum;
    wire cout;
    integer i = 32'sd0;
    integer pass = 32'sd0;
    integer fail = 32'sd0;

    half_adder dut (
        .a(a),
        .b(b),
        .sum(sum),
        .cout(cout)
    );

    task check;
        input ok;
        begin
            if (ok === 1'b1) begin
                pass = pass + 32'sd1;
                $display("PASS half_adder test=%0d", i);
            end
            else begin
                fail = fail + 32'sd1;
                $display("FAIL half_adder test=%0d", i);
            end
        end
    endtask

    initial begin
        for (i = 32'sd0; i < 32'sd4; i = i + 32'sd1) begin
            {a, b} = i;
            #1;
            check({cout, sum} === ({1'b0, a} + {1'b0, b}));
        end
        $display("SUMMARY half_adder PASS=%0d FAIL=%0d", pass, fail);
        $finish;
    end

endmodule
