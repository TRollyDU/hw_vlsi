`timescale 1ns/1ps
module tb_prio_enc8_3;
reg [7:0] d;
integer ref_code, shifted;
wire [2:0] code;
wire valid;
integer i = 0, pass = 0, fail = 0;
prio_enc8_3 dut(.d(d), .code(code), .valid(valid));
task check;
    input ok;
    begin
        if (ok === 1'b1) begin pass = pass + 1; $display("PASS prio_enc8_3 test=%0d", i); end
        else begin fail = fail + 1; $display("FAIL prio_enc8_3 test=%0d", i); end
    end
endtask
initial begin

    for (i=0; i<256; i=i+1) begin
        d=i; ref_code=0; shifted=i;
        while (shifted>1) begin shifted=shifted/2; ref_code=ref_code+1; end
        #1; check((code === ref_code[2:0]) && (valid === (i!=0)));
    end
    $display("SUMMARY prio_enc8_3 PASS=%0d FAIL=%0d", pass, fail);
    $finish;
end
endmodule
