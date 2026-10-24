`timescale 1ns/1ps
module tb_alu4;
reg [3:0] a,b,ref_y;
reg [2:0] op;
reg ref_flag;
integer value;
wire [3:0] y;
wire carry_borrow,zero;
integer i = 0, pass = 0, fail = 0;
alu4 dut(.a(a), .b(b), .op(op), .y(y), .carry_borrow(carry_borrow), .zero(zero));
task check;
    input ok;
    begin
        if (ok === 1'b1) begin pass = pass + 1; $display("PASS alu4 test=%0d", i); end
        else begin fail = fail + 1; $display("FAIL alu4 test=%0d", i); end
    end
endtask
initial begin

    for (i=0; i<32; i=i+1) begin
        op=i%8;
        case(i/8) 0:{a,b}=8'h00; 1:{a,b}=8'hf1; 2:{a,b}=8'h5a; 3:{a,b}=8'h88; endcase
        ref_flag=0; value=0;
        case(op)
            0: begin value=a+b; ref_flag=(value>15); end
            1: begin value=a-b; ref_flag=(a<b); end
            2:value=a&b; 3:value=a|b; 4:value=a^b; 5:value=15-a;
            6:value=a*2; 7:value=a/2;
        endcase
        ref_y=value; #1;
        check(y === ref_y && carry_borrow === ref_flag && zero === (ref_y==0));
    end
    $display("SUMMARY alu4 PASS=%0d FAIL=%0d", pass, fail);
    $finish;
end
endmodule
