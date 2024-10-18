module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
); 

    assign out_sop = (c&d) | ((~a)&(~b)&(c));
    assign out_pos = out_sop;

    // assign out_pos = (c) & ((~a) | b) & ((~b) | d) & ((~d) | b) ;
    // input 3 occurs in testcase
endmodule
