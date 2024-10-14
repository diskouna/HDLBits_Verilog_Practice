`timescale 1ps/1ps

module top_module ( );
    reg clk;
    initial begin
       clk = 0;
       forever begin
          #5;
          clk = ~clk;
       end
    end
    
    dut DUT(
        .clk(clk)
    );
endmodule
