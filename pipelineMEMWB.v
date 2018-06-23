`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Arizona
// Engineer: Rohin and Tam
// 
// Create Date: 10/31/2016 02:14:09 PM
// Design Name: 
// Module Name: pipelineIFID
//////////////////////////////////////////////////////////////////////////////////


module pipelineMEMWB(Clk, inRegDest, inMemData, inALUResult, inRd, inRt, inData1, inPCCounter, inMemRead,
                        outRegDest, outMemData, outALUResult, outRd, outRt, outData1, outPCCounter, outMemRead,
                        inHazardRegWrite, inHazardMemToRegMux,
                        outHazardRegWrite, outHazardMemToRegMux);
                                                
    //Input signal                
    input Clk;
    input [1:0] inMemRead;
    input [4:0] inRegDest, inRd, inRt;
    input [31:0] inMemData, inALUResult, inData1, inPCCounter;
    //Output signal
    output reg [1:0] outMemRead;
    output reg [4:0] outRegDest, outRd, outRt;
    output reg [31:0] outMemData, outALUResult, outData1, outPCCounter;
    //Selector signal
    input inHazardRegWrite;
    input [2:0] inHazardMemToRegMux;
    output reg outHazardRegWrite;
    output reg [2:0] outHazardMemToRegMux;
    
    always @ (posedge Clk)
    begin
        //if (inHazardWB != 0)
        //begin
            outRegDest <= inRegDest;
            outMemData <= inMemData;
            outALUResult <= inALUResult;
            outRt <= inRt;
            outRd <= inRd;
            outData1 <= inData1;
            outPCCounter <= inPCCounter;
            outMemRead <= inMemRead;
        //end
        outHazardRegWrite <= inHazardRegWrite;
        outHazardMemToRegMux <= inHazardMemToRegMux;
    end
    
endmodule
