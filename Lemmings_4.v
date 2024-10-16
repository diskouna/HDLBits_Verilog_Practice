module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging
 ); 
    // Satured Counter
    reg [4 : 0] counter;
    reg init_c, incr_c;

    always @(posedge clk or posedge areset) 
        if (areset)       counter <= 5'd0;
        else if (init_c) counter <= 5'd0;
        else if (incr_c) begin 
             if (counter == 5'd20) counter <= counter; 
             else                  counter <= counter + 5'd1;
        end

    wire falling_too_long =  (counter >= 20); // cycle >= 21

    // FSM
    parameter [2:0] LEFT       = 0, 
                    RIGHT      = 1,
                    FAIL_LEFT  = 2,
                    FAIL_RIGHT = 3,
                    DIG_LEFT   = 4,
                    DIG_RIGHT  = 5, 
                    DEAD       = 6;

    reg [2:0] state, next_state;

    always @(*) begin
        init_c = 1'b1;
        incr_c = 1'b0;
        // State transition logic
        next_state = state;
        case(state)
            LEFT : begin
                if (ground == 1'b0) next_state = FAIL_LEFT;
                else if (dig)       next_state = DIG_LEFT; 
                else if (bump_left) next_state = RIGHT;
                
            end
            
            FAIL_LEFT: begin
                init_c = 1'b0; incr_c = 1'b1; 
                if (ground == 1'b1) begin
                    if (falling_too_long) next_state = DEAD;
                    else                  next_state = LEFT;
                end
            end
            
            DIG_LEFT: begin
                if (ground == 1'b0) next_state = FAIL_LEFT;
            end

            RIGHT : begin
                if (ground == 1'b0)   next_state = FAIL_RIGHT;
                else if (dig)         next_state = DIG_RIGHT;
                else if (bump_right)  next_state = LEFT; 
            end
            
            FAIL_RIGHT: begin
                init_c = 1'b0; incr_c = 1'b1; 
                if (ground == 1'b1) begin
                    if (falling_too_long) next_state = DEAD;
                    else                  next_state = RIGHT;
                end
            end

            DIG_RIGHT: begin
                if (ground == 1'b0) next_state = FAIL_RIGHT;
            end
            
            DEAD : next_state = DEAD;

            default : begin 
                next_state = LEFT;
            end
        endcase
    end

    always @(posedge clk, posedge areset) begin
        // State flip-flops with asynchronous reset
        if (areset) state <= LEFT;
        else        state <= next_state;
    end

    // Output logic
    assign walk_left  = (state == LEFT );
    assign walk_right = (state == RIGHT);
    assign aaah       = (state == FAIL_LEFT) | (state == FAIL_RIGHT);
    assign digging    = (state == DIG_LEFT) | (state == DIG_RIGHT);

endmodule
