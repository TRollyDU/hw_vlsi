`timescale 1ns/1ps

module tb_mux4_8b;

    reg [7:0] d0;
    reg [7:0] d1;
    reg [7:0] d2;
    reg [7:0] d3;
    reg [7:0] ref_y;
    reg [1:0] sel;
    wire [7:0] y;
    integer i = 32'sd0;
    integer pass = 32'sd0;
    integer fail = 32'sd0;

    mux4_8b dut (
        .d0(d0),
        .d1(d1),
        .d2(d2),
        .d3(d3),
        .sel(sel),
        .y(y)
    );

    task check;
        input ok;
        begin
            if (ok === 1'b1) begin
                pass = pass + 32'sd1;
                $display("PASS mux4_8b test=%0d", i);
            end
            else begin
                fail = fail + 32'sd1;
                $display("FAIL mux4_8b test=%0d", i);
            end
        end
    endtask

    initial begin
        for (i = 32'sd0; i < 32'sd20; i = i + 32'sd1) begin
            sel = i % 32'sd4;
            d0 = $random;
            d1 = $random;
            d2 = $random;
            d3 = $random;
            if (i < 32'sd4) begin
                d0 = 8'd0;
                d1 = 8'd255;
                d2 = 8'd85;
                d3 = 8'd170;
            end
            case (sel)
                2'd0: ref_y = d0;
                2'd1: ref_y = d1;
                2'd2: ref_y = d2;
                2'd3: ref_y = d3;
            endcase
            #1;
            check(y === ref_y);
        end
        $display("SUMMARY mux4_8b PASS=%0d FAIL=%0d", pass, fail);
        $finish;
    end

endmodule
