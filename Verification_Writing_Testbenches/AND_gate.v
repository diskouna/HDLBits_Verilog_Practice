module top_module();
    reg a, b;
    wire c;
    
    andgate dut (
        .in({a, b}),
        .out(c)
    );
    
    initial begin
       a = 1'b0;
       b = 1'b0;
       #10 b = 1'b1;
       #10 a = 1'b1; b = 1'b0;
       #10 b = 1'b1;
    end
endmodule
