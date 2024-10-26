module top_module(
    input clk,
    input in,
    input reset,
    output out); //


    parameter A=0, B=1, C=2, D=3;
    reg [1:0] state, next_state;

    always @(*)begin
        next_state = state;
        case(state)
            A: if (in==1'b1) next_state = B;
            B: if (in==1'b0) next_state = C;
            C: if (in==1'b0) next_state = A;
               else          next_state = D;
            D: if (in==1'b0) next_state = C;
               else          next_state = B;
            default : next_state = A;
        endcase
    end

    always @(posedge clk)
        if(reset)   state <= A;
        else         state <= next_state;

    // Output logic
    assign out = (state == D);

endmodule
