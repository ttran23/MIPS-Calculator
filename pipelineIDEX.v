`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Arizona
// Engineer: Rohin and Tam
// 
// Create Date: 10/31/2016 02:14:09 PM
// Design Name: 
// Module Name: pipelineIFID
//////////////////////////////////////////////////////////////////////////////////


module pipelineIDEX(Clk, inRs, inRt, inRd, inData1, inData2, inInstruct, inShamt, inImme,inALUOP, inHazard, inPCCounter,
                    outRs, outRt, outRd, outData1, outData2, outInstruct, outShamt, outImme, outALUOP, outPCCounter,
                    inHazardRegWrite, inHazardALUSrc1Mux, inHazardMemRead, inHazardMemWrite, inHazardRegDestMux, inHazardMemToRegMux, inHazardALUOp, inHazardFlush,
                    outHazardRegWrite, outHazardALUSrc1Mux, outHazardMemRead, outHazardMemWrite, outHazardRegDestMux, outHazardMemToRegMux, outHazardALUOp);
              
    //Input signal      
    input Clk, inHazardFlush, inHazard;
    input [4:0] inRs, inRt, inRd, inShamt, inALUOP;
    input [31:0] inData1, inData2, inImme;
    input [31:0] inInstruct, inPCCounter;
    //Output signal
    output reg [4:0] outRs, outRt, outRd, outShamt, outALUOP;
    output reg [31:0] outData1, outData2, outImme;
    output reg [31:0] outInstruct, outPCCounter;
    //Selector signal
    input inHazardRegWrite, inHazardALUSrc1Mux;
    input [1:0] inHazardMemRead, inHazardMemWrite, inHazardRegDestMux;
    input [2:0] inHazardMemToRegMux;
    input [4:0] inHazardALUOp;
    output reg outHazardRegWrite, outHazardALUSrc1Mux;
    output reg [1:0] outHazardMemRead, outHazardMemWrite, outHazardRegDestMux;
    output reg [2:0] outHazardMemToRegMux;
    output reg [4:0] outHazardALUOp;
    
    always @ (posedge Clk)
    begin
    //if (~inHazardFlush) begin
        // If there is NO stall
        if (~inHazardFlush && ~inHazard)
        begin
            outRs <= inRs;
            outRt <= inRt;
            outRd <= inRd;
            outData1 <= inData1;
            outData2 <= inData2;
            outShamt <= inShamt;
            outImme <= inImme;
            outInstruct <= inInstruct;
            outALUOP <= inALUOP;
            outPCCounter <= inPCCounter;
            outHazardRegWrite <= inHazardRegWrite;
            outHazardALUSrc1Mux <= inHazardALUSrc1Mux;
            outHazardMemRead <= inHazardMemRead;
            outHazardMemWrite <= inHazardMemWrite;
            outHazardRegDestMux <= inHazardRegDestMux;
            outHazardMemToRegMux <= inHazardMemToRegMux;
            outHazardALUOp <= inHazardALUOp;
        end
        else begin
           outRs <= 0;
           outRt <= 0;
           outRd <= 0;
           outData1 <= 0;
           outData2 <= 0;
           outShamt <= 0;
           outImme <= 0;
           outInstruct <= 0;
           outALUOP <= 0;
           outPCCounter <= 0;
           outHazardRegWrite <= 0;
           outHazardALUSrc1Mux <= 0;
           outHazardMemRead <= 0;
           outHazardMemWrite <= 0;
           outHazardRegDestMux <= 0;
           outHazardMemToRegMux <= 0;
           outHazardALUOp <= 0;
        end
    end
    
endmodule
