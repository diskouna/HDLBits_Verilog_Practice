module top_module(
    input clk,
    input reset,    // Active-high synchronous reset to 5'h1
    output reg [4:0] q
); 
    reg [4:0] q_next;
    
    always @(*) begin
        q_next = {q[0], q[4:1]};
        q_next[2] = q[3] ^ q[0];
        q_next[4] = q[0];
    end
    
    always @(posedge clk)
        if (reset) q <= 5'h1;
    	else       q <= q_next;
    
endmodule
