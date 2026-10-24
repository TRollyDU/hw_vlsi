`timescale 1ns/1ps

module tb_lfsr8;

    reg clk = 1'b0;
    reg rst = 1'b0;
    reg en = 1'b0;
    reg [255:0] seen = 256'd0;
    reg [7:0] first[0:7];
    wire [7:0] q;
    integer i = 32'sd0;
    integer pass = 32'sd0;
    integer fail = 32'sd0;

    always #10
        clk = ~clk;

    lfsr8 dut (
        .clk(clk),
        .rst(rst),
        .en(en),
        .q(q)
    );

    task check;
        input ok;
        begin
            if (ok === 1'b1) begin
                pass = pass + 32'sd1;
                $display("PASS lfsr8 test=%0d time=%0t", i, $time);
            end
            else begin
                fail = fail + 32'sd1;
                $display("FAIL lfsr8 test=%0d time=%0t", i, $time);
            end
        end
    endtask

    initial begin
        first[0] = 8'd2;
        first[1] = 8'd4;
        first[2] = 8'd8;
        first[3] = 8'd17;
        first[4] = 8'd35;
        first[5] = 8'd71;
        first[6] = 8'd142;
        first[7] = 8'd28;
        #1;
        rst = 1'b1;
        #1;
        check(q === 8'h01);
        for (i = 32'sd0; i < 32'sd255; i = i + 32'sd1) begin
            @(negedge clk);
            rst = 1'b0;
            en = 1'b1;
            @(posedge clk);
            #1;
            check(q != 8'd0 && !seen[q]);
            if (i < 32'sd8) check(q === first[i]);
            seen[q] = 32'sd1;
        end
        check(q === 8'h01);
        @(negedge clk);
        en = 1'b0;
        repeat (32'sd3) begin
            @(posedge clk);
            #1;
            check(q === 8'h01);
        end
        #1;
        rst = 1'b1;
        #1;
        check(q === 8'h01);
        $display("SUMMARY lfsr8 PASS=%0d FAIL=%0d", pass, fail);
        $finish;
    end

endmodule
