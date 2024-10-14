module top_module(
    input clk,
    input load,
    input [1:0] ena,
    input [99:0] data,
    output reg [99:0] q); 

    reg [99:0] q_next;
    
    always @(*) begin
    	q_next = q;
        if (ena[0]) q_next = {q_next[0], q_next[99:1]};
        if (ena[1]) q_next = {q_next[98:0], q_next[99]};
        if (load)   q_next = data;
    end
    
    always @(posedge clk) q <= q_next;
    
endmodule
