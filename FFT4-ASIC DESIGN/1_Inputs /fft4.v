`timescale 1ns/1ps

module fft4(
    input clk,
    input reset,

    // 4-bit signed inputs
    input signed [3:0] x0,
    input signed [3:0] x1,
    input signed [3:0] x2,
    input signed [3:0] x3,

    // 6-bit signed outputs
    output reg signed [5:0] X0,
    output reg signed [5:0] X1,
    output reg signed [5:0] X2,
    output reg signed [5:0] X3
);

    // Intermediate registers
    reg signed [4:0] A0, A1, A2, A3;

    always @(posedge clk or posedge reset)
    begin
        if (reset)
        begin
            A0 <= 0;
            A1 <= 0;
            A2 <= 0;
            A3 <= 0;

            X0 <= 0;
            X1 <= 0;
            X2 <= 0;
            X3 <= 0;
        end
        else
        begin
            // Stage 1 Butterfly
            A0 <= x0 + x2;
            A1 <= x0 - x2;

            A2 <= x1 + x3;
            A3 <= x1 - x3;

            // Stage 2 Butterfly
            X0 <= A0 + A2;
            X1 <= A1 + A3;
            X2 <= A0 - A2;
            X3 <= A1 - A3;
        end
    end

endmodule
