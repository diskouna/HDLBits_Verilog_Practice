module top_module (
    input clk,
    input reset,     // synchronous reset
    input w,
    output z);
    localparam [2 : 0] A = 3'd0,
    				   B = 3'd1,
                       C = 3'd2,
                       D = 3'd3,
      				   E = 3'd4,
    			       F = 3'd5;
    reg [2 : 0] cur_state, nxt_state;
    reg z_r;
    assign z = z_r;
    
    always @(posedge clk) begin
        if (reset) cur_state <=A;
        else       cur_state <= nxt_state;
    end
    
    always @(*) begin
       z_r = 1'b0;
        nxt_state = cur_state;
        case(cur_state) 
            A: begin
                if(w == 1'b0) nxt_state = B;
            end
            B:begin
                if (w == 1'b0) nxt_state = C;
                else           nxt_state = D;
            end
            C: begin
                if (w==1'b0) nxt_state = E;
                else         nxt_state = D;
            end
            D: begin
                if (w==1'b0) nxt_state = F;
                else         nxt_state = A;
            end
            E: begin
                z_r = 1'b1;
                if (w == 1'b1) nxt_state = D;
            end
            F:begin
                z_r = 1'b1;
                if (w == 1'b0) nxt_state = C;
                else           nxt_state = D;
            end
            default: begin
                nxt_state = A;
            end
        endcase     
    end
endmodule
