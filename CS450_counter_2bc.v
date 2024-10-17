module top_module(
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

