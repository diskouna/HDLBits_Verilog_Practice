module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output shift_ena,
    output counting,
    input done_counting,
    output done,
    input ack );

    // Datapath
    reg [1:0] counter;
    reg init_c, incr_c;
    wire clock_4 = (counter == 2'b11);
    always @(posedge clk)
        if (reset) counter <= 2'd0;
        else if (init_c) counter <= 2'd0;
        else if (incr_c) counter <= counter + 2'd1;
    // FSM
    localparam I      = 0,
               W_1    = 1,
               W_11   = 2,
               W_110  = 3,
               W_1101 = 4,
               C      = 5,
               D      = 6;
    reg [2:0] cur_state, nxt_state;
    
    assign shift_ena = (cur_state == W_1101);
    assign counting  = (cur_state == C);
    assign done      = (cur_state == D);
 
    always @(*) begin
        init_c = 1'b1;
        incr_c = 1'b0;
        
        nxt_state = cur_state;
        case(cur_state)
            I     : if (data)          nxt_state = W_1;
            W_1   : if (data)          nxt_state = W_11;
                    else               nxt_state = I;
            W_11  : if (!data)         nxt_state = W_110;
            W_110 : if (data)          nxt_state = W_1101;
                    else               nxt_state = I;  
            W_1101: begin
                        init_c = 1'b0; incr_c = 1'b1;
                        if (clock_4)   nxt_state = C;
                    end
            C     : if (done_counting) nxt_state = D;
            D     : if (ack)           nxt_state = I;
        endcase
    end

    always @(posedge clk)
        if (reset) cur_state <= I;
        else       cur_state <= nxt_state;

endmodule
