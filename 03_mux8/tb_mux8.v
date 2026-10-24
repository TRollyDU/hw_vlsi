`timescale 1ns/1ps

module tb_mux8;

    reg [7:0] d;
    reg [2:0] sel;
    wire y;
    integer i = 32'sd0;
    integer pass = 32'sd0;
    integer fail = 32'sd0;

    mux8 dut (
        .d(d),
        .sel(sel),
        .y(y)
    );

    task check;
        input ok;
        begin
            if (ok === 1'b1) begin
                pass = pass + 32'sd1;
                $display("PASS mux8 test=%0d", i);
            end
            else begin
                fail = fail + 32'sd1;
                $display("FAIL mux8 test=%0d", i);
            end
        end
    endtask

    initial begin
        for (i = 32'sd0; i < 32'sd2048; i = i + 32'sd1) begin
            {d, sel} = i;
            #1;
            check(y === ((d >> sel) & 1'b1));
        end
        $display("SUMMARY mux8 PASS=%0d FAIL=%0d", pass, fail);
        $finish;
    end

endmodule
