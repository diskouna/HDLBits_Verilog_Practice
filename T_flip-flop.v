module top_module ();
	reg clk, reset, t;
    wire q;
    
    tff dut (
        .clk(clk),
        .reset(reset),
        .t(t),
        .q(q)
    );
    
    initial begin
    	clk = 1'b0;
        forever begin
           #5;
           clk = ~clk;
        end
    end
    
    initial begin
        t <= 1'b0;
        reset <= 1'b1;
        @(posedge clk) begin
            reset <= 1'b0;
       		t <= 1'b1;
        end
        @(posedge clk) t <= 1'b0;
    end
endmodule
