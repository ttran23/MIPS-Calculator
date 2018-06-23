`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Arizona
// Engineer: Rohin and Tam
// 
// Create Date: 10/31/2016 02:14:09 PM
// Design Name: 
// Module Name: pipelineIFID
//////////////////////////////////////////////////////////////////////////////////


module hazardUnit(Clk, inMemRead, inIDEXRt, inIFIDRs, inIFIDRt,
                    hazardPCWrite, hazardIFIDWrite, hazardMux);

    input Clk;
    input inMemRead;
    input [4:0] inIDEXRt, inIFIDRs, inIFIDRt;
    
    output reg hazardPCWrite, hazardIFIDWrite, hazardMux; 
    
    // HAZARD CONVENTION: output = 1, hazard detected   output = 0, no hazard 
//    initial begin
//            hazardPCWrite <= 0;
//            hazardIFIDWrite <= 0;
//            hazardMux <= 0;
//    end
    
    always @(*) 
    begin
        // Hazard after Read
        if (inMemRead && ((inIDEXRt == inIFIDRs) || (inIDEXRt == inIFIDRt)))
        begin
            hazardPCWrite = 1;
            hazardIFIDWrite = 1;
            hazardMux = 1;
        end 
        else
        begin
            hazardPCWrite <= 0;
            hazardIFIDWrite <= 0;
            hazardMux <= 0;           
        end
    end
    
    // Read after Write
    // Write after Write
endmodule
