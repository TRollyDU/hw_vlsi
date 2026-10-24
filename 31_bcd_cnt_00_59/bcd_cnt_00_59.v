module bcd_cnt_00_59(input clk, rst, tick, output reg [3:0] tens, ones);
always @(posedge clk or posedge rst) begin
    if (rst) begin tens<=0; ones<=0; end
    else if (tick) begin
        if (ones==9) begin
            ones<=0;
            if (tens==5) tens<=0;
            else tens<=tens+1'b1;
        end
        else ones<=ones+1'b1;
    end
end
endmodule
