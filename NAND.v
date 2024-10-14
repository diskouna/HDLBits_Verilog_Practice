module top_module (input a, input b, input c, output out);//
	
    wire o;
    assign out = ~o;
    
    andgate inst1 ( .a(a), .b(b), .c(c), .out(o), .d(1'b1), .e(1'b1));

endmodule
