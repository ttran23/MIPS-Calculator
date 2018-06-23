`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Arizona
// Engineer: Rohin and Tam
// 
// Create Date: 10/31/2016 02:14:09 PM
// Design Name: 
// Module Name: pipelineIFID
//////////////////////////////////////////////////////////////////////////////////


module pipelineEXMEM(Clk, inRegDest, inALUResult, inData2, inRd, inRt, inData1, inPCCounter,
                        outRegDest, outALUResult, outData2,outRd, outRt, outData1, outPCCounter,
                        inHazardRegWrite, inHazardMemRead, inHazardMemWrite,  inHazardMemToRegMux,
                        outHazardRegWrite, outHazardMemRead, outHazardMemWrite,  outHazardMemToRegMux);
                                      
    //Input signal               
    input Clk;
    input [4:0] inRegDest, inRd, inRt;
    input [31:0] inALUResult, inData2, inData1, inPCCounter;
    //Output signal
    output reg [4:0] outRegDest, outRd, outRt;
    output reg [31:0] outALUResult, outData2, outData1, outPCCounter;
    //Selector signal
    input inHazardRegWrite;
    input [1:0] inHazardMemRead, inHazardMemWrite;
    input [2:0] inHazardMemToRegMux;
    output reg outHazardRegWrite;
    output reg [1:0] outHazardMemRead, outHazardMemWrite;
    output reg [2:0] outHazardMemToRegMux;
    
    always @ (posedge Clk)
    begin
        //lmfao good luck
        //if (inHazardWB != 0 && inHazardM != 0)
        //begin
            outRegDest <= inRegDest;
            outALUResult <= inALUResult;
            outData2 <= inData2;
            outRd <= inRd;
            outRt <= inRt;
            outData1 <= inData1;
            outPCCounter <= inPCCounter;
        //end
        outHazardRegWrite <= inHazardRegWrite;
        outHazardMemRead <= inHazardMemRead;
        outHazardMemWrite <= inHazardMemWrite;
        outHazardMemToRegMux <= inHazardMemToRegMux;
    end
    
endmodule
