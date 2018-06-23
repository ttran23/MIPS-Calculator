`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/11/2016 01:47:07 PM
// Design Name: 
// Module Name: Mux32Bit4To1
//////////////////////////////////////////////////////////////////////////////////


module Mux32Bit4To1(out, inA, inB, inC, inD, sel);

    input [31:0] inA, inB, inC, inD;
    input [1:0] sel;
    
    output reg [31:0] out;
    
    always @ (inA, inB, inC, inD, sel)
    begin
        //case(sel)
            if(sel == 3'b000)  out <= inA;
            if(sel == 3'b001) out <= inB;
            if(sel == 3'b010) out <= inC;
            if(sel == 3'b011) out <= inD;
        //endcase
    end
endmodule


