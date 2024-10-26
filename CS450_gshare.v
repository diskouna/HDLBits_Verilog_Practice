`default_nettype none

module history_register (
    input clk,
    input areset,

    input predict_valid,
    input predict_taken,
    output [6:0] predict_history,

    input train_mispredicted,
    input train_taken,
    input [6:0] train_history
);
    reg [6:0] hist_shift_reg_q, hist_shift_reg_d;
    
    assign predict_history  = hist_shift_reg_q;
    
    always @(*) begin
    	hist_shift_reg_d = hist_shift_reg_q;
        if (predict_valid) begin
            hist_shift_reg_d =  {hist_shift_reg_q[5:0], predict_taken};
        end
        if (train_mispredicted) begin
            hist_shift_reg_d =  {train_history[5:0], train_taken};
        end
    end 
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
        	hist_shift_reg_q <= 7'd0;
        end
        else begin
           hist_shift_reg_q <= hist_shift_reg_d; 
        end
    end 
endmodule

module counter_2bc (
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output [1:0] state
);
    localparam [1 : 0] SNT = 2'b00,
    				   WNT = 2'b01,
    				   WT  = 2'b10,
    				   ST  = 2'b11;
    
    reg [1 : 0] cur_state, nxt_state;
    assign state = cur_state;
    
    always @(*) begin
    	nxt_state = cur_state;
        case(cur_state) 
            SNT: begin
                if (train_valid & train_taken)
                    nxt_state = WNT;
            end
            WNT: begin
                if (train_valid & train_taken)
                    nxt_state = WT;
                else if (train_valid & !train_taken)
                    nxt_state = SNT;
            end
            WT : begin
                if (train_valid & train_taken)
                    nxt_state = ST;
                else if (train_valid & !train_taken)
                    nxt_state = WNT;
            end
            
            ST: begin
                if (train_valid & !train_taken)
                    nxt_state = WT;
            end
            default :
                nxt_state = WNT;
        endcase
        
    end 
    
    always @(posedge clk or posedge areset) begin
        if(areset) begin 
           cur_state <= WNT; 
        end 
        else begin 
           cur_state <= nxt_state;
        end 
    end
endmodule

module top_module (
    input clk,
    input areset,

    input  predict_valid,
    input  [6:0] predict_pc,
    output reg predict_taken,
    output [6:0] predict_history,

    input train_valid,
    input train_taken,
    input train_mispredicted,
    input [6:0] train_history,
    input [6:0] train_pc
);
   /* Global history shift register */     
   history_register glob_b_hist_r (
         .clk (clk),
         .areset (areset),
         .predict_valid (predict_valid),
         .predict_taken (predict_taken),
         .predict_history (predict_history),
         .train_mispredicted (train_valid & train_mispredicted),
         .train_taken (train_taken),
         .train_history (train_history)
    );

   /* Pattern History Table   */
   // Indexes
   wire [6:0] predict_table_index =  predict_pc ^ predict_history; 
   wire [6:0] train_table_index   =  train_pc   ^ train_history; 
   // Interfaces
   reg       train_valid_pht[0:127];
   reg       train_taken_pht[0:127];
   wire [1:0] state[0:127];
   integer i; 
   // Input/Output decoder 
   always @(*) begin
      for (i=0; i < 128; i = i + 1) begin
            train_valid_pht[i] = 1'b0;
            train_taken_pht[i] = 1'b0; 
      end
      predict_taken = state[predict_table_index][1]; 
      train_valid_pht[train_table_index] = train_valid;
      train_taken_pht[train_table_index] = train_taken;
   end
   // Counters
   genvar c;
   generate
        for (c=0; c < 128; c = c + 1) begin : counter 
            counter_2bc inst (
                .clk(clk),
                .areset(areset),
                .train_valid(train_valid_pht[c]),
                .train_taken(train_taken_pht[c]),
                .state(state[c])
            );
        end
   endgenerate

endmodule
