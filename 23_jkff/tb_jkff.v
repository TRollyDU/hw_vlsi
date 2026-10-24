`timescale 1ns/1ps

module tb_jkff;

    reg clk = 1'b0;
    reg rst = 1'b0;
    reg j = 1'b0;
    reg k = 1'b0;
    reg ref_q;
    wire q;
    integer i = 32'sd0;
    integer pass = 32'sd0;
    integer fail = 32'sd0;

    always #10
        clk = ~clk;

    jkff dut (
        .clk(clk),
        .rst(rst),
        .j(j),
        .k(k),
        .q(q)
    );

    task check;
        input ok;
        begin
            if (ok === 1'b1) begin
                pass = pass + 32'sd1;
                $display("PASS jkff test=%0d time=%0t", i, $time);
            end
            else begin
                fail = fail + 32'sd1;
                $display("FAIL jkff test=%0d time=%0t", i, $time);
            end
        end
    endtask

    initial begin
        #1;
        rst = 1'b1;
        #1;
        check(q === 1'b0);
        ref_q = 1'b0;
        for (i = 32'sd0; i < 32'sd8; i = i + 32'sd1) begin
            @(negedge clk);
            rst = 1'b0;
            case (i)
                32'sd0, 32'sd4: {j, k} = 2'b10;
                32'sd1, 32'sd5: {j, k} = 2'b00;
                32'sd2, 32'sd6: {j, k} = 2'b11;
                32'sd3, 32'sd7: {j, k} = 2'b01;
            endcase
            ref_q = (j & ~ref_q) | (~k & ref_q);
            @(posedge clk);
            #1;
            check(q === ref_q);
        end
        #1;
        rst = 1'b1;
        #1;
        check(q === 1'b0);
        $display("SUMMARY jkff PASS=%0d FAIL=%0d", pass, fail);
        $finish;
    end

endmodule
