module tick1hz_50m #(parameter integer CLOCK_HZ=50000000)
    (input clk, rst, output reg tick);
integer count;
always @(posedge clk or posedge rst) begin
    if (rst) begin count<=0; tick<=0; end
    else if (count==CLOCK_HZ-1) begin count<=0; tick<=1; end
    else begin count<=count+1; tick<=0; end
end
endmodule
