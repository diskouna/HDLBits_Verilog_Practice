module top_module(
    input a,
    input b,
    input c,
    output out  ); 

    //assign out = a | c | b; // SOP
    assign out  = (a | b | c); //POS

endmodule
