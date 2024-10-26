module top_module(
    input clk,
    input reset,    // Active-high synchronous reset to 32'h1
    output reg [31:0] q
); 
    reg [31:0] q_next;
    
    always @(*) begin
        q_next =  {q[0], q[31:1]};
        q_next[32-1] = 1'b0  ^ q[0]; 
        q_next[22-1] = q[22] ^ q[0];
        q_next[2-1]  = q[2]  ^ q[0]; 
        q_next[1-1]  = q[1]  ^ q[0];
    end
    
    always @(posedge clk)
        if(reset) q <= 32'd1;
    	else      q <= q_next;
    
endmodule
