module top_module (
    input [3:1] y,
    input w,
    output Y2);
    
    localparam [3:1] A = 0, B = 1, C = 2, D = 3, E = 4, F = 5;
 
    //                  C                          D
    assign Y2 = (!w & ((y==B) | (y==F))) | (w & ((y==B) | (y==C) | (y==E) | (y==F)));

endmodule
