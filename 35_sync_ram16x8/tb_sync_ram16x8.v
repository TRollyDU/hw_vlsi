`timescale 1ns/1ps

module tb_sync_ram16x8;

    reg clk = 1'b0;
    reg en = 1'b0;
    reg we = 1'b0;
    reg [3:0] addr = 4'd0;
    reg [7:0] din = 8'd0;
    reg [7:0] ref_data;
    wire [7:0] dout;
    integer i = 32'sd0;
    integer pass = 32'sd0;
    integer fail = 32'sd0;

    always #10
        clk = ~clk;

    sync_ram16x8 dut (
        .clk(clk),
        .en(en),
        .we(we),
        .addr(addr),
        .din(din),
        .dout(dout)
    );

    task check;
        input ok;
        begin
            if (ok === 1'b1) begin
                pass = pass + 32'sd1;
                $display("PASS sync_ram16x8 test=%0d time=%0t", i, $time);
            end
            else begin
                fail = fail + 32'sd1;
                $display("FAIL sync_ram16x8 test=%0d time=%0t", i, $time);
            end
        end
    endtask

    initial begin
        for (i = 32'sd0; i < 32'sd16; i = i + 32'sd1) begin
            @(negedge clk);
            en = 1'b1;
            we = 1'b1;
            addr = i;
            din = i * 32'sd13 + 8'd7;
            @(posedge clk);
            #1;
            check(dout === din);
        end
        for (i = 32'sd0; i < 32'sd16; i = i + 32'sd1) begin
            @(negedge clk);
            we = 1'b0;
            addr = 4'd15 - i;
            ref_data = (8'd15 - i) * 8'd13 + 8'd7;
            @(posedge clk);
            #1;
            check(dout === ref_data);
        end
        #1;
        addr = 4'd15;
        #1;
        check(dout === 8'd7);
        @(negedge clk);
        en = 1'b0;
        we = 1'b1;
        addr = 4'd0;
        din = 8'd255;
        @(posedge clk);
        #1;
        check(dout === 8'd7);
        @(negedge clk);
        en = 1'b1;
        we = 1'b0;
        @(posedge clk);
        #1;
        check(dout === 8'd7);
        @(negedge clk);
        we = 1'b1;
        din = 8'ha5;
        @(posedge clk);
        #1;
        check(dout === 8'ha5);
        @(negedge clk);
        we = 1'b0;
        din = 8'd0;
        @(posedge clk);
        #1;
        check(dout === 8'ha5);
        $display("SUMMARY sync_ram16x8 PASS=%0d FAIL=%0d", pass, fail);
        $finish;
    end

endmodule
