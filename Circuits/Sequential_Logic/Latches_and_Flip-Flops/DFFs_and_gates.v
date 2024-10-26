module top_module (
    input clk,
    input x,
    output z
); 
	
    reg [2 : 0] cur_state, nxt_state;
    always @(*) begin
        nxt_state[0] = x ^ cur_state[0];
        nxt_state[1] = x & (~cur_state[1]);
        nxt_state[2] = x | (~cur_state[2]);
    end
    assign z = ~|cur_state;
    always @(posedge clk) cur_state <= nxt_state;
    
endmodule
