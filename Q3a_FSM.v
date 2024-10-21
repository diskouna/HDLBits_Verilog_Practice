`default_nettype none

module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output reg z
);
    // Datapath
    reg [2:0] ws;
    always @(posedge clk) begin
        if(reset) ws <= 3'b000;
        else      ws <= {ws[1:0], w}; 
    end
    
    wire two_1 = ((!ws[0] & ws[1]  & ws[2]) | 
                  (ws[0]  & !ws[1] & ws[2]) |
                  (ws[0]  & ws[1]  & !ws[2])
                 );
    
    //  FSM
    localparam A = 0,
               B = 1,
               C_1 = 2,
               C_2 = 3, C_3 = 4;

    reg [3:0] cur_state, nxt_state;
    

    always @(*) begin
        z = 1'b0;

        nxt_state = cur_state;
        case(cur_state)
            A       : if (s) begin 
                        nxt_state = B;
                      end
            B       : begin 
                        nxt_state = C_1;
                      end
            C_1     : begin
                        nxt_state = C_2;
                      end
            C_2     : begin
                        nxt_state = C_3;
                      end
            C_3     : begin
                        nxt_state = C_1;
                        z = two_1;
                      end
            default : nxt_state = A;
        endcase
    end    
    
    always @(posedge clk) 
        if (reset) cur_state <= A;
        else       cur_state <= nxt_state;

endmodule

