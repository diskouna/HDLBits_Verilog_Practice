module top_module(
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output out); //

    parameter A=0, B=1, C=2, D=3;

    // State transition logic: next_state = f(state, in)
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

    // Output logic:  out = f(state) for a Moore state machine
    assign out = (state == D);
endmodule
