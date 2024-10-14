module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done); //

    reg [2 : 0] load;
    
    // FSM from fsm_ps2

    localparam [1 : 0] IDLE =  2'd0, F = 2'd1, S = 2'd2, T = 2'd3;
    reg [3 : 0] cur_state, nxt_state;
    
    // State transition logic (combinational)
    always @(*) begin
        load = 3'd0;
    	nxt_state = cur_state;
        case(1'b1)
            cur_state[IDLE]: if (in[3] == 1'b1) begin
                load[2] = 1'b1;
                nxt_state = (1'b1 << F); 
            end
            cur_state[F]   : begin
                load[1] = 1'b1;
                nxt_state = (1'b1 << S);
            end
            cur_state[S]   : begin
                load[0] = 1'b1;
                nxt_state = (1'b1 << T);
            end
            cur_state[T]   : if (in[3] == 1'b0) nxt_state = (1'b1 << IDLE);
                             else  begin
                                 load[2] = 1'b1;
                                 nxt_state = (1'b1 << F);
                             end
            default        : nxt_state = (1'b1 << IDLE);
        endcase
    end
    
    // State flip-flops (sequential)
    always @(posedge clk)
        if (reset) cur_state <= (1'b1 << IDLE);
    	else       cur_state <= nxt_state;
    
    // Output logic
    assign done = cur_state[T];
    
    // New: Datapath to store incoming bytes.
    reg [23 : 0] out_bytes_r;
    assign out_bytes = out_bytes_r;
    always @(posedge clk) begin
        if (reset) out_bytes_r <= 24'd0;
        else begin
            case (1'b1)
                load[0] : out_bytes_r[ 7: 0] <= in;
                load[1] : out_bytes_r[15: 8] <= in;
                load[2] : out_bytes_r[23:16] <= in;
                default : out_bytes_r        <= out_bytes_r; 
            endcase
        end
    end
endmodule
