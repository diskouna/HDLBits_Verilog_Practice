module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input x,
    input y,
    output f,
    output g
); 
    localparam A     = 0, 
               B     = 1,
               W_    = 2,
               W_1   = 3,
               W_10  = 4,
               C_1   = 5,
               C_2   = 6,
               D     = 7,
               E     = 8;

    reg [3:0] cur_state, nxt_state;
    
    assign f = (cur_state == B);
    assign g = (cur_state == C_1 | cur_state == C_2 | cur_state == D);

    always @(*) begin
        nxt_state = cur_state;
        case(cur_state)
            A    : nxt_state = B;
            B    : nxt_state = W_;
            /* Monitor x */
            W_   : if (x) nxt_state = W_1;
            W_1  : if (!x) nxt_state = W_10;
                   else    nxt_state = W_1;
            W_10 : if (x) nxt_state = C_1;
                   else   nxt_state = W_;
            /* Monitor y */
            C_1   : if (y) nxt_state = D;
                    else   nxt_state = C_2;
            C_2   : if (y) nxt_state = D;
                    else   nxt_state = E;
            /* End states */
            D     :        nxt_state = D;         // g=1
            E     :        nxt_state = E;         // g=0
            default :      nxt_state = A;
        endcase
    end    

    always @(posedge clk)
        if (!resetn) cur_state <= A;
        else         cur_state <= nxt_state;
  
endmodule
