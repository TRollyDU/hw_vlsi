`timescale 1ns/1ps

module tb_fsm_1011;

    reg clk = 1'b0;
    reg rst = 1'b0;
    reg din = 1'b0;
    reg [39:0] stream = 40'b1011011000010111110010101110101101101100;
    reg [3:0] history = 4'd0;
    integer count = 32'sd0;
    wire detect;
    integer i = 32'sd0;
    integer pass = 32'sd0;
    integer fail = 32'sd0;

    always #10
        clk = ~clk;

    fsm_1011 dut (
        .clk(clk),
        .rst(rst),
        .din(din),
        .detect(detect)
    );

    task check;
        input ok;
        begin
            if (ok === 1'b1) begin
                pass = pass + 32'sd1;
                $display("PASS fsm_1011 test=%0d time=%0t", i, $time);
            end
            else begin
                fail = fail + 32'sd1;
                $display("FAIL fsm_1011 test=%0d time=%0t", i, $time);
            end
        end
    endtask

    initial begin
        #1;
        rst = 1'b1;
        #1;
        check(detect === 1'b0);
        for (i = 32'sd0; i < 32'sd40; i = i + 32'sd1) begin
            @(negedge clk);
            rst = (i == 32'sd12);
            din = stream[39 - i];
            if (rst) begin
                history = 4'd0;
                count = 32'sd0;
                #1;
                check(detect === 1'b0);
            end
            else begin
                history = {history[2:0], din};
                count = count + 32'sd1;
            end
            @(posedge clk);
            #1;
            check(detect === (!rst && count >= 32'sd4 && history == 4'b1011));
        end
        $display("SUMMARY fsm_1011 PASS=%0d FAIL=%0d", pass, fail);
        $finish;
    end

endmodule
