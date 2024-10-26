module top_module(
    input clk,
    input areset,

    input predict_valid,
    input predict_taken,
    output [31:0] predict_history,

    input train_mispredicted,
    input train_taken,
    input [31:0] train_history
);
    reg [31:0] hist_shift_reg_q, hist_shift_reg_d;
    
    assign predict_history  = hist_shift_reg_q;
    
    always @(*) begin
    	hist_shift_reg_d = hist_shift_reg_q;
        if (predict_valid) begin
            hist_shift_reg_d =  {hist_shift_reg_q[30:0], predict_taken};
        end
        if (train_mispredicted) begin
            hist_shift_reg_d =  {train_history[30:0], train_taken};
        end
    end 
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
        	hist_shift_reg_q <= 32'd0;
        end
        else begin
           hist_shift_reg_q <= hist_shift_reg_d; 
        end
    end 
endmodule
