module top_module (
    input [3:0] SW,
    input [3:0] KEY,
    output [3:0] LEDR
); //

    wire clk = KEY[0];
    wire E   = KEY[1];
    wire L   = KEY[2];
    wire w   = KEY[3];

    wire [3:0] R = SW;
    wire [3:0] Q;
    assign LEDR = Q;

    MUXDFF muxdff_3 (clk, E, L,    w, Q[3], R[3], Q[3]);       
    MUXDFF muxdff_2 (clk, E, L, Q[3], Q[2], R[2], Q[2]);       
    MUXDFF muxdff_1 (clk, E, L, Q[2], Q[1], R[1], Q[1]);       
    MUXDFF muxdff_0 (clk, E, L, Q[1], Q[0], R[0], Q[0]);       

endmodule

module MUXDFF (
    input clk,
    input sel_1,
    input sel_2,
    input a, b, c,

    output reg q
);
    
    wire q_next = sel_2 ? c : (sel_1 ? a : b);

    always @(posedge clk) 
        q <= q_next;

endmodule
