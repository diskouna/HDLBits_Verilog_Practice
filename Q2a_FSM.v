module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    input w,
    output z
);
    localparam A = 0, B = 1, C = 2, D = 3, E = 4, F = 5;
    reg [2:0] cur_state, next_state;
    
    always @(posedge clk) begin
        if (reset) cur_state  <= A;
        else       cur_state  <= next_state; 
    end
    
    always @(*) begin
        next_state = cur_state;
        case(cur_state)
            A : if (w==1'b1)      next_state = B;
            B : if (w==1'b1)      next_state = C;
                else              next_state = D;
            C : if (w==1'b1)      next_state = E;
                else              next_state = D;
            D : if (w==1'b1)      next_state = F;
                else              next_state = A;
            E : if (w==1'b1)      next_state = E;
                else              next_state = D;
            F : if (w==1'b1)      next_state = C;
                else              next_state = D;
            default:              next_state = A;
        endcase
    end

    assign z = (cur_state == E) | (cur_state == F);
    
endmodule
