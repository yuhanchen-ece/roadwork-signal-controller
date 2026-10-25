`timescale 1ns/1ps

module roadwork_controller_tb();
    localparam A_CYCLES = 5, B_CYCLES = 7,  C_CYCLES = 2;

    reg clk;
    reg reset;
    wire a_go;
    wire a_stop;
    wire b_go;
    wire b_stop;

    roadwork_controller dut (.clk(clk), .reset(reset), .a_go(a_go), .a_stop(a_stop), .b_go(b_go), .b_stop(b_stop));

    initial begin
        clk = 1'b0;
        reset = 1'b1;
        #20 reset = 1'b0;
        @(posedge clk);
        #6 reset = 1'b1;
        #5 reset = 1'b0;
        #21 $finish;
    end

    always #5 clk = ~clk;

    initial begin
    $dumpfile("sim/roadwork.vcd");
    $dumpvars(0, roadwork_controller_tb);
    end

endmodule