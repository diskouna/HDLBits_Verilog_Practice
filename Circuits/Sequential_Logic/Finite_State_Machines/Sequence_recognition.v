module top_module(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output disc,
    output flag,
    output err
);
    
    localparam I          = 0,
               W_0        = 1,
               W_01       = 2,
               W_011      = 3,
               W_0111     = 4,
               W_01111    = 5,
               W_011111   = 6,
               W_0111110  = 7,
               W_0111111  = 8,
               W_01111110 = 9,
               W_01111111 = 10;
    reg [3:0] cur_state, nxt_state;
    
	assign disc = (cur_state == W_0111110);
	assign flag = (cur_state == W_01111110);
	assign err  = (cur_state == W_01111111);

    always @(*) begin
        
        nxt_state = cur_state;
        case(cur_state) 
            I                  : if (!in)  nxt_state = W_0;
            W_0                : if (in)   nxt_state = W_01;
                                 else      nxt_state = W_0;
            W_01               : if (in)   nxt_state = W_011;
                                 else      nxt_state = W_0;
            W_011              : if (in)   nxt_state = W_0111;
                                 else      nxt_state = W_0;
            W_0111             : if (in)   nxt_state = W_01111;
                                 else      nxt_state = W_0;
            W_01111            : if (in)   nxt_state = W_011111;
                                 else      nxt_state = W_0;
            W_011111           : if (in)   nxt_state = W_0111111;
                                 else      nxt_state = W_0111110;   // disc
            W_0111110          : if (in)   nxt_state = W_01;  
                                 else      nxt_state = W_0;
            W_0111111          : if (in)   nxt_state = W_01111111;  // err
                                 else      nxt_state = W_01111110;  // flag 
            W_01111110         : if (in)   nxt_state = W_01;
                                 else      nxt_state = W_0;
            W_01111111         : if (!in)  nxt_state = W_0;

            default            :           nxt_state = I;
        endcase
    end    

    always @(posedge clk)
        if (reset)  cur_state <= W_0;
        else        cur_state <= nxt_state;

endmodule
