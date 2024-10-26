module top_module (
    input clk,
    input a,
    input b,
    output q,
    output reg state  );

    // Use karnaugh map to compute nxt_state logic 

    always @(posedge clk) begin
        state <= (a & b) | (a & state) | (b & state); // at least two ones in {a, b, state}
    end

    assign q = (a ^ b ^ state);
 
endmodule
