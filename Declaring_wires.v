`default_nettype none
module top_module(
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n   ); 

    wire out_tmp;
    assign out = out_tmp;
    assign out_n = ~out_tmp;
    
    assign out_tmp = (a & b) | (c & d);
    
endmodule
