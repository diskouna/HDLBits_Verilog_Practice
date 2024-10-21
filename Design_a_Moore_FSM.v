module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
); 

    localparam [2:0] L_0_S1  = 3'd0, L_0_S1_d  = 3'd4,
                     L_S1_S2 = 3'd1, L_S1_S2_d = 3'd5,
                     L_S2_S3 = 3'd2, L_S2_S3_d = 3'd6,
                     L_S3_S9 = 3'd3; 

    reg [2:0] cur_state, nxt_state;

    assign dfr = cur_state[2] | (cur_state == L_0_S1);

    assign fr3 = (cur_state[1:0] == 2'b00);
    assign fr2 = !cur_state[1];
    assign fr1 = (cur_state[1:0] != 2'b11);
    
    always @(*) begin
        nxt_state = cur_state;
        case(cur_state) 
            L_0_S1 : begin
                if (s[1])      nxt_state = L_S1_S2;
            end
            L_S1_S2: begin
                if (s[2])      nxt_state = L_S2_S3;
                else if(!s[1]) nxt_state = L_0_S1_d;
            end
            L_S2_S3: begin
                if (s[3])       nxt_state = L_S3_S9;
                else if (!s[2]) nxt_state = L_S1_S2_d;
            end
            L_S3_S9: begin
                if (!s[3])      nxt_state = L_S2_S3_d;
            end
            L_0_S1_d: begin
                if (s[1])       nxt_state = L_S1_S2;
            end
            L_S1_S2_d: begin
                if (s[2])       nxt_state = L_S2_S3;
                else if (~s[1]) nxt_state = L_0_S1_d;
            end
            L_S2_S3_d: begin
                if (s[3])       nxt_state = L_S3_S9;
                else if (~s[2]) nxt_state = L_S1_S2_d;
            end
            default  :          nxt_state = L_0_S1;
        endcase
    end


    always @(posedge clk)
        if (reset) cur_state <= L_0_S1;
        else       cur_state <= nxt_state;
    
endmodule
