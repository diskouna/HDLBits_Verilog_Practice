module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //

    // Use FSM from Fsm_serial
    localparam [2 : 0] IDLE  = 3'd0,
    			       START = 3'd1,
    				   DATA  = 3'd2,
    			       STOP  = 3'd3,
    				   DONE  = 3'd4,
    				   ERROR = 3'd5;
    				  
    
    reg [2 : 0] cur_state, nxt_state;
    reg done_r;
    assign done = done_r;
    
    always @(posedge clk) begin
        if (reset) cur_state <= IDLE;
        else       cur_state <= nxt_state;
    end
    
    reg [2: 0] data_count;
    reg init_c, count_c, shift;
    
    always @(posedge clk) begin
        if (reset) data_count <= 3'd0;
        else begin
            if (count_c) data_count <= data_count + 3'd1;
            if (init_c)  data_count <= 3'd0;
        end
    end
    
    always @(*) begin
       nxt_state = cur_state;
       done_r = 1'b0;
       init_c = 1'b1;
       count_c = 1'b0;
       shift = 1'b0;
        
       case(cur_state)
            IDLE: begin 
                if (in == 1'b0) nxt_state = DATA;         // START bit       
            end
            DATA : begin
                if (data_count >= 3'd7) nxt_state = STOP; // END of transmission
                    init_c = 1'b0;
                    count_c = 1'b1;
                    shift = 1'b1;
                
            end 
            STOP: begin 
                if (in == 1'b1) nxt_state = DONE;         // STOP bit
                else            nxt_state = ERROR;        // DISCARDS CURRENT BYTE
            end
            ERROR: begin
                if (in == 1'b1) nxt_state = IDLE;
            end
            DONE : begin 
               done_r = 1'b1;
               if(in == 1'b0) nxt_state = DATA;  // START detected
               else           nxt_state = IDLE;
            end
            default: begin
                nxt_state = IDLE;
            end
        endcase
    end
    // New: Datapath to latch input bits.
    reg [7 : 0] data_r;
    assign out_byte = data_r;
    always @(posedge clk) begin
        if (reset) begin
           data_r <= 8'b0; 
        end
        else begin 
            if (shift) data_r <= {in, data_r[7 : 1]};
        end
    end

endmodule
