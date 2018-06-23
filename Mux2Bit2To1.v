`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2016 04:02:38 PM
// Design Name: 
// Module Name: Mux2Bit2To1
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Mux2Bit2To1(out, inA, inB, sel);

    output reg [1:0] out;
    
    input [1:0] inA;
    input [1:0] inB;
    input sel;

    /* Fill in the implementation here ... */ 
    always @ (inA, inB, sel)
    begin
        if (sel == 0)
            out <= inA;
        else if (sel == 1)
            out <= inB;
    end
endmodule
