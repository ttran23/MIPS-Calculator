`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - Mux32Bit2To1.v
// Description - Performs signal multiplexing between 2 32-Bit words.
////////////////////////////////////////////////////////////////////////////////

module Mux32Bit2To1(out, inA, inB, sel);

    output reg [31:0] out;
    
    input [31:0] inA;
    input [31:0] inB;
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
