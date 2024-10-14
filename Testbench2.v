module top_module();
    reg clk, in;
    reg [2:0] s;
    wire out;
    
    q7	dut (
        .clk (clk),
        .in (in),
        .s (s),
        .out(out)
    );
    // CLOCK
    initial begin
       clk = 1'b0;
       forever begin
          #5;
          clk = ~clk;
       end
    end
    // in and s 
    initial begin
        in <= 1'b0;
        s <= 3'd2;
        @(negedge clk) begin 
            s <= 3'd6;
        end
        @(negedge clk) begin
            in <= 1'b1;
            s <= 3'd2;
        end
        
        @(negedge clk) begin 
            in <= 1'b0;
            s <= 3'd7;
        end
        @(negedge clk) begin 
            in <= 1'b1;
            s <= 3'd0;
        end
        repeat(3) @(negedge clk) ;
        in <= 1'b0;
    end 
    
endmodule
