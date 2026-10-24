`timescale 1ns/1ps

module tb_bin_gray;

    reg [3:0] bin_in;
    reg [3:0] gray_in;
    reg [3:0] ref_gray;
    integer j;
    wire [3:0] gray_out;
    wire [3:0] bin_out;
    integer i = 32'sd0;
    integer pass = 32'sd0;
    integer fail = 32'sd0;

    bin_gray dut (
        .bin_in(bin_in),
        .gray_in(gray_in),
        .gray_out(gray_out),
        .bin_out(bin_out)
    );

    task check;
        input ok;
        begin
            if (ok === 1'b1) begin
                pass = pass + 32'sd1;
                $display("PASS bin_gray test=%0d", i);
            end
            else begin
                fail = fail + 32'sd1;
                $display("FAIL bin_gray test=%0d", i);
            end
        end
    endtask

    initial begin
        for (i = 32'sd0; i < 32'sd16; i = i + 32'sd1) begin
            bin_in = i;
            ref_gray = 4'd0;
            ref_gray[3] = bin_in[3];
            for (j = 32'sd0; j < 32'sd3; j = j + 32'sd1)
                ref_gray[j] = (bin_in[j] != bin_in[j + 1]);
            gray_in = ref_gray;
            #1;
            check(gray_out === ref_gray && bin_out === bin_in);
        end
        $display("SUMMARY bin_gray PASS=%0d FAIL=%0d", pass, fail);
        $finish;
    end

endmodule
