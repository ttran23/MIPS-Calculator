`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2016 06:28:28 PM
// Design Name: 
// Module Name: Mux5Bit4To1
//////////////////////////////////////////////////////////////////////////////////


module Mux5Bit4To1(out, inA, inB, inC, inD, sel);

    output reg [4:0] out;
    
    input [4:0] inA, inB, inC, inD;
    input [1:0] sel;

    /* Fill in the implementation here ... */ 
    always @ (inA, inB, inC, inD, sel)
    begin
        case(sel)
            2'b00: out <= inA;
            2'b01: out <= inB;
            2'b10: out <= inC;
            2'b11: out <= inD;
        endcase
    end
endmodule
