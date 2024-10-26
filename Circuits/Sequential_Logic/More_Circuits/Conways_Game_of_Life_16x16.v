// i : row 
// j : column
`define CELL_AT(array, i, j) array[16*(i) + (j)]

module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q ); 

    reg [255:0] q_next;

    integer i, j, c_i, c_j, n_i, n_j;
    integer c_counts;

    always @(*) begin
        i = 0; j = 0; c_i = 0; c_j = 0; n_i = 0; n_j = 0; 
        c_counts = 0;

        q_next = q;
        if (load) q_next = data;
        else begin
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    c_counts = 0; 
                    for (c_i = -1; c_i <= 1; c_i = c_i + 1) begin
                        for (c_j = -1; c_j <= 1; c_j = c_j + 1) begin
                            if (c_i != 0 || c_j != 0) begin
                                n_i = c_i + i;
                                if (n_i == 16) n_i = 0;
                                if (n_i == -1) n_i = 15;

                                n_j = c_j + j;
                                if (n_j == 16) n_j = 0;
                                if (n_j == -1) n_j = 15;

                                c_counts = c_counts +  `CELL_AT(q, n_i, n_j);
                            end
                        end
                    end 
                    case (c_counts)
                        0, 1, 4, 5, 6, 7, 8 : `CELL_AT(q_next, i, j) = 1'b0;
                        3                   : `CELL_AT(q_next, i, j) = 1'b1;
                        default             : `CELL_AT(q_next, i, j) = `CELL_AT(q, i, j);
                    endcase
                end
            end            
        end
    end
   
    always @(posedge clk) q <= q_next;

endmodule
