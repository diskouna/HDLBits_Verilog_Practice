module top_module(
    input a,
    input b,
    input c,
    input d,
    output out  ); 
    
    assign out = a&c&d | b&c&d | (~c)&(~b) | (~a)&(~d);

endmodule
