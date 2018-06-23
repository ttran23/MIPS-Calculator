`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Arizona
// Engineer: Rohin and Tam
// 
// Create Date: 10/31/2016 02:14:09 PM
// Design Name: 
// Module Name: pipelineIFID
//////////////////////////////////////////////////////////////////////////////////


module pipelineIFID(Clk, inInstr, outInstr, hazardIFDWrite, hazardIFFlush, inPCCounter, outPCCounter);

    //Input signal
    input Clk;
    input [31:0] inInstr, inPCCounter;
    //Output signal
    output reg [31:0] outInstr, outPCCounter;
    //Selector signal
    input hazardIFDWrite, hazardIFFlush;
        
    always @ (posedge Clk) 
    begin
        if (~hazardIFFlush && ~hazardIFDWrite)
        begin
            outInstr <= inInstr;    //Else send out instr as normal
            outPCCounter <= inPCCounter;
        end
        if (hazardIFFlush)
        begin
            outInstr <= 32'd0;  //If stall, send out "nop" instruction
            outPCCounter <= 0; //necessary or not?       
        end
    
//        if (hazardIFFlush)
//        begin
//            outInstr <= 32'd0;  //If stall, send out "nop" instruction
//            outPCCounter <= 0; //necessary or not?
//        end
//        else
//        begin
//            outInstr <= inInstr;    //Else send out instr as normal
//            outPCCounter <= inPCCounter;
//        end
    end

endmodule
