module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output [3:0] count,
    output counting,
    output done,
    input ack );
    
    /* Datapath */
    // Counter_1
    reg [1:0] counter_1;
    reg init_c1, incr_c1;
    wire clock_4 = (counter_1 == 2'b11);
    always @(posedge clk)
        if (reset) counter_1 <= 2'd0;
        else if (init_c1) counter_1 <= 2'd0;
        else if (incr_c1) counter_1 <= counter_1 + 2'd1;    
    // Shift register
    wire shift_ena;
    reg decr_sr;
    reg [3:0] delay;
    assign count = delay;
    always @(posedge clk)
        if (reset)          delay <= 4'd0;
        else if (shift_ena) delay <= {delay[2:0], data};  
        else if (decr_sr)   delay <= delay - 4'd1;
    // Counter_2
    reg [9:0] counter_1000;
    reg init_c1000, incr_c1000;
    always @(posedge clk)
        if (reset) counter_1000 <= 10'd0;
        else if (init_c1000) counter_1000 <= 10'd0;
        else if (incr_c1000) begin
             if (counter_1000 == 10'd999)
                counter_1000 <= 10'd0;
             else
                counter_1000 <= counter_1000 + 10'd1;
        end
 
    wire done_counting_1000 = (counter_1000 == 10'd999);
    wire done_counting = (delay==4'h0) & done_counting_1000;
    
    /* FSM */
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
        init_c1    = 1'b1;
        incr_c1    = 1'b0;
        init_c1000 = 1'b1;
        incr_c1000 = 1'b0;
        decr_sr    =  1'b0;

        nxt_state = cur_state;
        case(cur_state)
            I     : if (data)          nxt_state = W_1;
            W_1   : if (data)          nxt_state = W_11;
                    else               nxt_state = I;
            W_11  : if (!data)         nxt_state = W_110;
            W_110 : if (data)          nxt_state = W_1101;
                    else               nxt_state = I;  
            W_1101: begin
                        init_c1 = 1'b0; incr_c1 = 1'b1;
                        if (clock_4)   nxt_state = C;
                    end
            C     : begin 
                        init_c1000 = 1'b0; incr_c1000 = 1'b1;                   
                        if (done_counting) 
                            nxt_state = D;
                        else if (done_counting_1000)
                            decr_sr = 1'b1;
                    end
            D     : if (ack)           nxt_state = I;
        endcase
    end

    always @(posedge clk)
        if (reset) cur_state <= I;
        else       cur_state <= nxt_state;


endmodule
