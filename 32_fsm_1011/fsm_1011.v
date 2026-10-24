module fsm_1011 (
    input clk,
    input rst,
    input din,
    output reg detect
);

    localparam S0 = 2'd0;
    localparam S1 = 2'd1;
    localparam S2 = 2'd2;
    localparam S3 = 2'd3;
    reg [1:0] state;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= S0;
            detect <= 1'b0;
        end
        else begin
            detect <= (state == S3 && din);
            case (state)
                S0: state <= din ? S1 : S0;
                S1: state <= din ? S1 : S2;
                S2: state <= din ? S3 : S0;
                S3: state <= din ? S1 : S2;
                default: state <= S0;
            endcase
        end
    end

endmodule
