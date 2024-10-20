module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output reg z ); 

    localparam W    = 0,
               W_1  = 1,
               W_10 = 2;
    reg [1:0] cur_state, nxt_state;
    
    always @(*) begin
        z = 1'b0;
        nxt_state = cur_state;
        case(cur_state) 
            W   : if (x)   nxt_state = W_1;
                  else     nxt_state = W;
            W_1 : if (!x)  nxt_state = W_10;
            W_10: if (x)   begin 
                    nxt_state = W_1;
                    z = 1'b1;   //W_101
                  end
                  else     nxt_state = W;
            default:       nxt_state = W;
        endcase
    end

    always @(posedge clk or negedge aresetn)
        if (!aresetn) cur_state <= W;
        else          cur_state <= nxt_state;

endmodule
