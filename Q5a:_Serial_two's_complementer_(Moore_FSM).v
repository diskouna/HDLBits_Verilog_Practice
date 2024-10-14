module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
	
    localparam [0 : 0] BF_RM1 = 1'd0, //Before rightmost one 
    	               AF_RM1 = 1'd1; //After     "       "
    reg [0 : 0] cur_state, nxt_state;
    reg inv_r;
    
        
    always @(posedge clk or posedge areset) begin
        if (areset) cur_state <= BF_RM1;
        else        cur_state <= nxt_state;
    end
    
    // Datapath
    wire z_d;
    reg  z_q;
	assign z_d = (inv_r == 1'b1) ? ~x : x;
    assign z = z_q;
    
    always @(posedge clk or posedge areset)
        if (areset) z_q <= 1'b0;
    	else        z_q <= z_d;
    
    // FSM
    always @(*) begin
        inv_r = 1'b0;
    	nxt_state = cur_state;
        case(cur_state)
            BF_RM1 : begin
                if (x == 1'b1) nxt_state = AF_RM1; 
            end
            AF_RM1 : begin
               inv_r = 1'b1; 
            end
            default : nxt_state = BF_RM1;
        endcase
    end
    
endmodule
