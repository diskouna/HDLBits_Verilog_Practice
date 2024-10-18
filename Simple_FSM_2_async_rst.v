module top_module(
    input clk,
    input areset,    // Asynchronous reset to OFF
    input j,
    input k,
    output out); //  

    parameter OFF=0, ON=1; 
    reg state, next_state;

    always @(*) begin
        // State transition logic
        next_state = state;
        case(state)
            OFF: if (j==1) next_state = ON;
            ON : if (k==1) next_state = OFF;
            default : next_state = OFF;
        endcase
    end

    always @(posedge clk, posedge areset) begin
        // State flip-flops with asynchronous reset
        if(areset) state <= OFF;
        else       state <= next_state;
    end

    // Output logic
    assign out = (state == ON);

endmodule
