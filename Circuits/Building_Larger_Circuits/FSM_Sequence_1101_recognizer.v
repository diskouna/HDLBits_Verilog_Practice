module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output start_shifting);

    localparam I=0, A = 1, B = 2, C = 3, D = 4;
    reg [2:0] cur_state, nxt_state;
    always @(posedge clk)
        if(reset) cur_state <= I;
        else      cur_state <= nxt_state;
    
    always @(*) begin
        nxt_state = cur_state;
        case (cur_state)
            I: if (data==1'b1) nxt_state = A;
            A: if (data==1'b1) nxt_state = B;
               else            nxt_state = I;
            B: if (data==1'b0) nxt_state = C;
               else            nxt_state = B;
            C: if (data==1'b1) nxt_state = D;
               else            nxt_state = I;
            D: nxt_state = D;
        endcase
    end

    assign start_shifting = (cur_state == D);

endmodule
