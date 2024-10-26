module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output done); //
	
    localparam [1 : 0] IDLE =  2'd0, F = 2'd1, S = 2'd2, T = 2'd3;
    reg [3 : 0] cur_state, nxt_state;
    
    // State transition logic (combinational)
    always @(*) begin
    	nxt_state = cur_state;
        case(1'b1)
            cur_state[IDLE]: if (in[3] == 1'b1) nxt_state = (1'b1 << F); 
            cur_state[F]   : nxt_state = (1'b1 << S);
            cur_state[S]   : nxt_state = (1'b1 << T);
            cur_state[T]   : if (in[3] == 1'b0) nxt_state = (1'b1 << IDLE);
                             else               nxt_state = (1'b1 << F);
            default        : nxt_state = (1'b1 << IDLE);
        endcase
    end
    
    // State flip-flops (sequential)
    always @(posedge clk)
        if (reset) cur_state <= (1'b1 << IDLE);
    	else       cur_state <= nxt_state;
    
    // Output logic
    assign done = cur_state[T];
    
endmodule
