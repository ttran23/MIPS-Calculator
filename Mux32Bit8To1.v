`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2016 06:43:27 PM
// Design Name: 
// Module Name: Mux32Bit8To1
//////////////////////////////////////////////////////////////////////////////////


module Mux32Bit8To1(out, inA, inB, inC, inD,
            inE, inF, inG, inH, sel);

    input [31:0] inA, inB, inC, inD,
            inE, inF, inG, inH;
    input [2:0] sel;
    
    output reg [31:0] out;
    
    always @ (inA, inB, inC, inD, inE, inF, inG, inH, sel)
    begin
        //case(sel)
            if(sel == 3'b000)  out <= inA;
            if(sel == 3'b001) out <= inB;
            if(sel == 3'b010) out <= inC;
            if(sel == 3'b011) out <= inD;
            if(sel == 3'b100) out <= inE;
            if(sel == 3'b101) out <= inF;
            if(sel == 3'b110) out <= inG;
            if(sel == 3'b111) out <= inH;
        //endcase
    end
endmodule
