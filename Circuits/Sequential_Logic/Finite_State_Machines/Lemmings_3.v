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

    parameter [2:0] LEFT       = 0, 
                    RIGHT      = 1,
                    FAIL_LEFT  = 2,
                    FAIL_RIGHT = 3,
                    DIG_LEFT   = 4,
                    DIG_RIGHT  = 5;

    reg [2:0] state, next_state;

    always @(*) begin
        // State transition logic
        next_state = state;
        case(state)
            LEFT : begin
                if (ground == 1'b0) next_state = FAIL_LEFT;
                else if (dig)       next_state = DIG_LEFT; 
                else if (bump_left) next_state = RIGHT;
                
            end
            
            FAIL_LEFT: begin
                if (ground == 1'b1) next_state = LEFT;
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
                if (ground == 1'b1) next_state = RIGHT;
            end

            DIG_RIGHT: begin
                if (ground == 1'b0) next_state = FAIL_RIGHT;
            end
            
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
