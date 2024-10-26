module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
    localparam [0:0] A = 1'd0, B = 1'd1;
    reg [1:0] cur_state, nxt_state;
    reg z_r;
    assign z = z_r;
    
    always @(*) begin
    	z_r = 1'b0;
        nxt_state = cur_state;
        case(1'b1) 
            cur_state[A] : begin
                z_r = x;
                if (x == 1'b1) begin
                    nxt_state = (1'b1 << B);
                end
            end
            cur_state[B] : begin
                z_r = ~x; 
            end
            default : nxt_state = (1'b1 << A);
        endcase
    end
    
    always @(posedge clk or posedge areset)
        if (areset) cur_state <= (1'b1 << A);
    	else        cur_state <= nxt_state;
    
endmodule
