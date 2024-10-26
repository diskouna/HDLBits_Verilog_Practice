module top_module(
    input clk,
    input areset,  // async active-high reset to zero
    input load,
    input ena,
    input [3:0] data,
    output reg [3:0] q); 

    reg [3 : 0] q_next;
    
    always @(*) begin
    	q_next = q;
        if (ena)  q_next = {1'b0, q[3:1]};
        if (load) q_next = data;
    end
    
    always @(posedge clk or posedge areset)
        if(areset) q <= 4'h0;
    	else       q <= q_next;
    
endmodule
