`timescale 1ns/1ps

module fft4_main(
    input clk_pad,
    input reset_pad,

    // 4-bit signed inputs
    input signed [3:0] x0_pad,
    input signed [3:0] x1_pad,
    input signed [3:0] x2_pad,
    input signed [3:0] x3_pad,

    // 6-bit signed outputs
    output  signed [5:0] X0_pad,
    output  signed [5:0] X1_pad,
    output  signed [5:0] X2_pad,
    output  signed [5:0] X3_pad
);


    wire clk;
    wire reset;

    // 4-bit signed inputs
    wire signed [3:0] x0;
    wire signed [3:0] x1;
    wire signed [3:0] x2;
    wire signed [3:0] x3;

    // 6-bit signed outputs
     reg signed [5:0] X0;
     reg signed [5:0] X1;
     reg signed [5:0] X2;
     reg signed [5:0] X3;

     wire fft4_clk;

    //=====================================
// Clock Buffering
//=====================================
pc3c01 pc3c01_1 (.CCLK(fft4_clk), .CP(clk));
pc3d01 pc3d01_1 (.PAD(clk_pad), .CIN(fft4_clk));

// Reset input
pc3d01 pc3d01_2 (.PAD(reset_pad), .CIN(reset));

// FFT inputs
pc3d01 pc3d01_3 (.PAD(x0_pad[0]), .CIN(x0[0]));
pc3d01 pc3d01_4 (.PAD(x0_pad[1]), .CIN(x0[1]));
pc3d01 pc3d01_5 (.PAD(x0_pad[2]), .CIN(x0[2]));
pc3d01 pc3d01_6 (.PAD(x0_pad[3]), .CIN(x0[3]));

pc3d01 pc3d01_7 (.PAD(x1_pad[0]), .CIN(x1[0]));
pc3d01 pc3d01_8 (.PAD(x1_pad[1]), .CIN(x1[1]));
pc3d01 pc3d01_9 (.PAD(x1_pad[2]), .CIN(x1[2]));
pc3d01 pc3d01_10 (.PAD(x1_pad[3]), .CIN(x1[3]));

pc3d01 pc3d01_11 (.PAD(x2_pad[0]), .CIN(x2[0]));
pc3d01 pc3d01_12 (.PAD(x2_pad[1]), .CIN(x2[1]));
pc3d01 pc3d01_13 (.PAD(x2_pad[2]), .CIN(x2[2]));
pc3d01 pc3d01_14 (.PAD(x2_pad[3]), .CIN(x2[3]));

pc3d01 pc3d01_15 (.PAD(x3_pad[0]), .CIN(x3[0]));
pc3d01 pc3d01_16 (.PAD(x3_pad[1]), .CIN(x3[1]));
pc3d01 pc3d01_17 (.PAD(x3_pad[2]), .CIN(x3[2]));
pc3d01 pc3d01_18 (.PAD(x3_pad[3]), .CIN(x3[3]));

// Output pads for X0
pc3o05 pc3o05_1 (.I(X0[0]), .PAD(X0_pad[0]));
pc3o05 pc3o05_2 (.I(X0[1]), .PAD(X0_pad[1]));
pc3o05 pc3o05_3 (.I(X0[2]), .PAD(X0_pad[2]));
pc3o05 pc3o05_4 (.I(X0[3]), .PAD(X0_pad[3]));
pc3o05 pc3o05_5 (.I(X0[4]), .PAD(X0_pad[4]));
pc3o05 pc3o05_6 (.I(X0[5]), .PAD(X0_pad[5]));

// Output pads for X1
pc3o05 pc3o05_7  (.I(X1[0]), .PAD(X1_pad[0]));
pc3o05 pc3o05_8  (.I(X1[1]), .PAD(X1_pad[1]));
pc3o05 pc3o05_9  (.I(X1[2]), .PAD(X1_pad[2]));
pc3o05 pc3o05_10 (.I(X1[3]), .PAD(X1_pad[3]));
pc3o05 pc3o05_11 (.I(X1[4]), .PAD(X1_pad[4]));
pc3o05 pc3o05_12 (.I(X1[5]), .PAD(X1_pad[5]));

// Output pads for X2
pc3o05 pc3o05_13 (.I(X2[0]), .PAD(X2_pad[0]));
pc3o05 pc3o05_14 (.I(X2[1]), .PAD(X2_pad[1]));
pc3o05 pc3o05_15 (.I(X2[2]), .PAD(X2_pad[2]));
pc3o05 pc3o05_16 (.I(X2[3]), .PAD(X2_pad[3]));
pc3o05 pc3o05_17 (.I(X2[4]), .PAD(X2_pad[4]));
pc3o05 pc3o05_18 (.I(X2[5]), .PAD(X2_pad[5]));

// Output pads for X3
pc3o05 pc3o05_19 (.I(X3[0]), .PAD(X3_pad[0]));
pc3o05 pc3o05_20 (.I(X3[1]), .PAD(X3_pad[1]));
pc3o05 pc3o05_21 (.I(X3[2]), .PAD(X3_pad[2]));
pc3o05 pc3o05_22 (.I(X3[3]), .PAD(X3_pad[3]));
pc3o05 pc3o05_23 (.I(X3[4]), .PAD(X3_pad[4]));
pc3o05 pc3o05_24 (.I(X3[5]), .PAD(X3_pad[5]));

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
