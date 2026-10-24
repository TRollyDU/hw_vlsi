`timescale 1ns/1ps
module tb_bin_gray;
reg [3:0] bin_in,gray_in,ref_gray;
integer j;
wire [3:0] gray_out,bin_out;
integer i = 0, pass = 0, fail = 0;
bin_gray dut(.bin_in(bin_in), .gray_in(gray_in), .gray_out(gray_out), .bin_out(bin_out));
task check;
    input ok;
    begin
        if (ok === 1'b1) begin pass = pass + 1; $display("PASS bin_gray test=%0d", i); end
        else begin fail = fail + 1; $display("FAIL bin_gray test=%0d", i); end
    end
endtask
initial begin

    for (i=0; i<16; i=i+1) begin
        bin_in=i; ref_gray=0; ref_gray[3]=bin_in[3];
        for (j=0; j<3; j=j+1) ref_gray[j]=(bin_in[j]!=bin_in[j+1]);
        gray_in=ref_gray; #1; check(gray_out === ref_gray && bin_out === bin_in);
    end
    $display("SUMMARY bin_gray PASS=%0d FAIL=%0d", pass, fail);
    $finish;
end
endmodule
