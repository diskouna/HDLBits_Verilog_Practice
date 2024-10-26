module top_module (
    input clk,
    input reset,   // Synchronous reset
    input x,
    output reg z
);

    reg [2:0] cur_state, nxt_state;
    
    always @(posedge clk)
        if (reset) cur_state <= 3'b000;
    	else       cur_state <= nxt_state;
    
    always @(*) begin
        z = 1'b0;
        nxt_state = cur_state;
        case(cur_state)
            3'b000: begin
                z = 1'b0;
                if (x) nxt_state = 3'b001;
                else   nxt_state = 3'b000;
            end
            3'b001: begin
                z = 1'b0;
                if (x) nxt_state = 3'b100;
                else   nxt_state = 3'b001;
            end
            3'b010: begin
                z = 1'b0;
                if (x) nxt_state = 3'b001;
                else   nxt_state = 3'b010;
            end
             3'b011: begin
                z = 1'b1;
                if (x) nxt_state = 3'b010;
                else   nxt_state = 3'b001;
            end    
            3'b100: begin
                z = 1'b1;
                if (x) nxt_state = 3'b100;
                else   nxt_state = 3'b011;
            end    
            default : begin
               nxt_state = 3'b000;
            end
        endcase
    end
endmodule
