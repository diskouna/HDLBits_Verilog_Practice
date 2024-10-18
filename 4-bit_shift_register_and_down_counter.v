module top_module (
    input clk,
    input shift_ena,
    input count_ena,
    input data,
    output reg  [3:0] q);

    // shift_ena has higher precedence over count_ena

    always @(posedge clk) begin
        if (shift_ena)      q <= {q[2:0], data};
        else if (count_ena) q <= q - 4'h1;       
    end

endmodule
