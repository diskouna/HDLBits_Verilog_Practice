module top_module (
    input clk,
    input reset,        // Synchronous active-high reset
    output [3:0] q);

    reg [3:0] q_r;
    assign q = q_r;
    
    always @(posedge clk) begin
        if (reset) q_r <= 4'h0;
        else begin
            if (q_r >= 4'd9) q_r <= 4'h0;
            else             q_r <= q_r + 4'h1;
        end
    end
endmodule
