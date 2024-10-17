module top_module(
	input clk, 
	input load, 
	input [9:0] data, 
	output tc
);
    reg [9 : 0] cur_counter, nxt_counter;
    
    assign tc = (cur_counter == 10'd0);
    
    always @(*) begin
        nxt_counter = cur_counter;
        if (load) nxt_counter = data;
        else begin 
            if (cur_counter == 10'd0) nxt_counter = 10'd0;
        	else                      nxt_counter = cur_counter - 10'd1;
        end
    end
    
    always @(posedge clk) cur_counter <= nxt_counter;
    
endmodule
