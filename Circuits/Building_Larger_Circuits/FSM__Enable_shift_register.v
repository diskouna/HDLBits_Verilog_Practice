module top_module (
    input clk,
    input reset,      // Synchronous reset
    output shift_ena);

   localparam C_1 = 0,
              C_2 = 1,
              C_3 = 2,
              C_4 = 3,
              C_E = 4;
   reg [2:0] cur_state, nxt_state;

   assign shift_ena = (cur_state != C_E);
   always @(*) begin
        nxt_state = cur_state;
        case(cur_state)
            C_1 : nxt_state = C_2;
            C_2 : nxt_state = C_3;
            C_3 : nxt_state = C_4;
            C_4 : nxt_state = C_E;
            C_E : nxt_state = C_E;
            default: nxt_state = C_1;
        endcase
   end
               
   always @(posedge clk)
        if (reset) cur_state <= C_1;
        else       cur_state <= nxt_state;

endmodule
