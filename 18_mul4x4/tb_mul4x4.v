`timescale 1ns/1ps

module tb_mul4x4;

    reg [3:0] a;
    reg [3:0] b;
    integer ref_product;
    wire [7:0] product;
    integer i = 32'sd0;
    integer pass = 32'sd0;
    integer fail = 32'sd0;

    mul4x4 dut (
        .a(a),
        .b(b),
        .product(product)
    );

    task check;
        input ok;
        begin
            if (ok === 1'b1) begin
                pass = pass + 32'sd1;
                $display("PASS mul4x4 test=%0d", i);
            end
            else begin
                fail = fail + 32'sd1;
                $display("FAIL mul4x4 test=%0d", i);
            end
        end
    endtask

    initial begin
        for (i = 32'sd0; i < 32'sd256; i = i + 32'sd1) begin
            {a, b} = i;
            ref_product = 32'sd0;
            repeat (b)
                ref_product = ref_product + a;
            #1;
            check(product === ref_product[7:0]);
        end
        $display("SUMMARY mul4x4 PASS=%0d FAIL=%0d", pass, fail);
        $finish;
    end

endmodule
