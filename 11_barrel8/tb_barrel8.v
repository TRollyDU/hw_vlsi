`timescale 1ns/1ps

module tb_barrel8;

    reg [7:0] d;
    reg [7:0] ref_y;
    reg [2:0] shamt;
    reg right;
    integer j;
    integer src;
    wire [7:0] y;
    integer i = 32'sd0;
    integer pass = 32'sd0;
    integer fail = 32'sd0;

    barrel8 dut (
        .d(d),
        .shamt(shamt),
        .right(right),
        .y(y)
    );

    task check;
        input ok;
        begin
            if (ok === 1'b1) begin
                pass = pass + 32'sd1;
                $display("PASS barrel8 test=%0d", i);
            end
            else begin
                fail = fail + 32'sd1;
                $display("FAIL barrel8 test=%0d", i);
            end
        end
    endtask

    initial begin
        for (i = 32'sd0; i < 32'sd4096; i = i + 32'sd1) begin
            {d, shamt, right} = i;
            for (j = 32'sd0; j < 32'sd8; j = j + 32'sd1) begin
                src = right ? (j + shamt) % 32'sd8 : (j + 32'sd8 - shamt) % 32'sd8;
                ref_y[j] = d[src];
            end
            #1;
            check(y === ref_y);
        end
        $display("SUMMARY barrel8 PASS=%0d FAIL=%0d", pass, fail);
        $finish;
    end

endmodule
