module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input [3:1] r,   // request
    output [3:1] g   // grant
); 
    localparam A = 0,
               B = 1,
               C = 2,
               D = 3;

    reg [3:0] cur_state, nxt_state;

    assign g = cur_state[3:1];

    always @(*) begin

        nxt_state = cur_state;
        case(1'b1)
            cur_state[A] : begin
                if (r[1])      nxt_state = (1'b1 <<  B);
                else if (r[2]) nxt_state = (1'b1 <<  C);
                else if (r[3]) nxt_state = (1'b1 <<  D);
            end
            cur_state[B] : begin
                if (!r[1])     nxt_state = (1'b1 <<  A);
            end
            cur_state[C] : begin
                if (!r[2])     nxt_state = (1'b1 <<  A);
            end
            cur_state[D] : begin
                if (!r[3])     nxt_state = (1'b1 <<  A);
            end
            default : nxt_state = (1'b1 << A);
        endcase
    end

    always @(posedge clk)
        if(!resetn) cur_state <= (1'b1 << A);
        else        cur_state <= nxt_state;

endmodule
