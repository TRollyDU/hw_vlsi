`timescale 1ns/1ps

module tb_prio_enc4_2;

    reg [3:0] d;
    integer ref_code;
    integer shifted;
    wire [1:0] code;
    wire valid;
    integer i = 32'sd0;
    integer pass = 32'sd0;
    integer fail = 32'sd0;

    prio_enc4_2 dut (
        .d(d),
        .code(code),
        .valid(valid)
    );

    task check;
        input ok;
        begin
            if (ok === 1'b1) begin
                pass = pass + 32'sd1;
                $display("PASS prio_enc4_2 test=%0d", i);
            end
            else begin
                fail = fail + 32'sd1;
                $display("FAIL prio_enc4_2 test=%0d", i);
            end
        end
    endtask

    initial begin
        for (i = 32'sd0; i < 32'sd16; i = i + 32'sd1) begin
            d = i;
            ref_code = 32'sd0;
            shifted = i;
            while (shifted > 32'sd1) begin
                shifted = shifted / 32'sd2;
                ref_code = ref_code + 32'sd1;
            end
            #1;
            check((code === ref_code[1:0]) && (valid === (i != 32'sd0)));
        end
        $display("SUMMARY prio_enc4_2 PASS=%0d FAIL=%0d", pass, fail);
        $finish;
    end

endmodule
