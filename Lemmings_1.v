module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right); //  

    parameter [0:0] LEFT=0, RIGHT=1; // SWITCH = ; ...
    reg state, next_state;

    always @(*) begin
        // State transition logic
        next_state = state;
        case(state)
            LEFT : begin
                if (bump_left) next_state = RIGHT;
            end
            
            RIGHT : begin
                if (bump_right)  next_state = LEFT; 
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
    assign walk_left = (state == LEFT);
    assign walk_right = (state == RIGHT);

endmodule
