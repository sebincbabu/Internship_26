4fft_tb.v

`timescale 1ns/1ps

module fft4_tb;

reg clk;
reg reset;

reg signed [3:0] x0;
reg signed [3:0] x1;
reg signed [3:0] x2;
reg signed [3:0] x3;

wire signed [5:0] X0;
wire signed [5:0] X1;
wire signed [5:0] X2;
wire signed [5:0] X3;

fft4 uut (
    .clk(clk),
    .reset(reset),
    .x0(x0),
    .x1(x1),
    .x2(x2),
    .x3(x3),
    .X0(X0),
    .X1(X1),
    .X2(X2),
    .X3(X3)
);

// 100 MHz clock
always #5 clk = ~clk;

initial begin

    clk = 0;
    reset = 1;

    x0 = 0;
    x1 = 0;
    x2 = 0;
    x3 = 0;

    // Hold reset
    #20;
    reset = 0;

    //-------------------------
    // Test Case 1
    //-------------------------
    #10;

    x0 = 4;
    x1 = 4;
    x2 = 4;
    x3 = 4;

    #40;

    $display("Test Case 1");
    $display("X0 = %d", X0);
    $display("X1 = %d", X1);
    $display("X2 = %d", X2);
    $display("X3 = %d", X3);

    //-------------------------
    // Test Case 2
    //-------------------------
    #10;

    x0 = 2;
    x1 = 3;
    x2 = 1;
    x3 = 5;

    #40;

    $display("Test Case 2");
    $display("X0 = %d", X0);
    $display("X1 = %d", X1);
    $display("X2 = %d", X2);
    $display("X3 = %d", X3);

    #20;
    $finish;

end

endmodule
