`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Arizona
// Engineer: Rohin Galhotra and Tam Tran
// Group 5
// Work breakdown: 50/50
// We started assigning parts but then we just caught each other's mistakes 
// So in the end we just worked on every file together. Every. Single. One.
// Five stage pipeline
// We resolve branches in execution stage
// 
//
// Create Date: 10/12/2016 09:20:26 AM
// Design Name: 
// Module Name: TopModule
//////////////////////////////////////////////////////////////////////////////////


    /*
    Instruction Fetch Unit From Lab 1-3, could be used later after modifications?
        module InstructionFetchUnit(Instruction, Reset, Clk);
        module PCAdder(PCResult, PCAddResult);
        module ProgramCounter(Address, PCResult, Reset, Clk);
        module InstructionMemory(Address, Instruction); 

    Modules from Labs 5-8, 9-15
        module instrMemory(readAddr, Instruction);
        module ALU32Bit(ALUControl, shamt, A, B, ALUResult, Zero, Clk, Branch);
        module ALUControl(ALUOp, funct, ALUControl);
        module Control(OpCode, MemRead, MemWrite, RegWrite, 
                        RegDestMux, MemToRegMux, 
                        ALUSrc1Mux, ALUOp);
        module DataMemory(Address, WriteData, Clk, MemWrite, MemRead, ReadData); 
        module Mux32Bit2To1(out, inA, inB, sel);
        module Mux32Bit8To1(out, inA, inB, inC, inD,
                    inE, inF, inG, inH, sel);
        module Mux5Bit4To1(out, inA, inB, inC, inD, sel);
        module RegisterFile(ReadRegister1, ReadRegister2, WriteRegister, WriteData, RegWrite, Clk, ReadData1, ReadData2);
        module SignExtension(in, out);
        module ThreeBitMux(out, in1, in2, in3, in4, in5, in6, in7, in8, sel);
        module Mux32Bit4To1(out, inA, inB, inC, inD, sel);
    */
    
//module TopModule(Rst, Clk, out7, en_out);
module TopModule(Rst, Clk, out, ProgramCounter);
    
    // Declarations
    input Rst;
    input Clk;
    output reg [31:0] out;
    output reg [31:0] ProgramCounter;
    //reg [31:0] out, ProgramCounter;
    //output [6:0] out7;      //this is not a reg as per detailed in Two4DigitDisplay
    //output [7:0] en_out;    
    wire [31:0] tempAddr, DtempAddr, EXtempAddr, MEMtempAddr, WBtempAddr;
    (* mark_debug = "true" *) wire [31:0] instr;
    
    // Previous signals
    wire RegWrite, Zero, ALUSrc1Mux, ClkOut;
    wire [1:0] RegDestMux, MemRead, MemWrite, WBMemRead;
    (* mark_debug = "true" *) wire [1:0] Branch;
    wire [2:0] MemToRegMux;
    wire [4:0] RegDest, ALUOp, EXALUOP;
    wire [5:0] ALUControl;
    (* mark_debug = "true" *) wire [31:0] ReadData1, ReadData2, RegWriteData,
                SignExtImmediate,  ALUResult, MemoryData;
    
    // New signals
    wire PCWrite, IFDWrite, IFFlush, EXRegWrite, EXALUSrc1Mux, MEMRegWrite, WBRegWrite, IDRegWrite, hazardMux;
    wire [1:0] EXMemRead, EXMemWrite, EXRegDestMux, MEMMemWrite, MEMMemRead,
               IDMemRead, IDMemWrite;
    (* mark_debug = "true" *) wire [1:0] ForwardA, ForwardB;
    wire [2:0] EXMemToRegMux, MEMMemToRegMux, WBMemToRegMux;
    wire [4:0] EXRs, EXRt, EXRd, MEMRegDest, WBRegDest, MEMRd, MEMRt, WBRd, WBRt,
               EXALUOp, EXShamt;
    (* mark_debug = "true" *) wire [31:0] EXData1, EXData2, ALUInTemp, ALUIn1, ALUIn2, EXImme, MEMALUResult, MEMData2, WBALUResult, WBMemoryData, MEMData1, WBData1; 
    (* mark_debug = "true" *) wire [31:0] inInstr; //we'll use instr as outInstr bc I don't wanna go and change our instr variable
    (* mark_debug = "true" *) wire [31:0] EXInstruct;
    (* mark_debug = "true" *) wire [31:0] s1,s2,s3,s4;
    

    ////////////////////////////////////////////////////////
    // Clk Div and Display
    ////////////////////////////////////////////////////////
    
    //Two4DigitDisplay display(.Clk(Clk), .NumberA(ProgramCounter), .NumberB(out), .out7(out7), .en_out(en_out));
    //ClkDiv(.Clk(Clk), .Rst(Rst), .ClkOut(ClkOut));
    
    ////////////////////////////////////////////////////////
    // Fetch Stage
    ////////////////////////////////////////////////////////
    
    //PC Adder implementation designed to handle branching and update Address
    PCAdder pcadding(.PCResult(tempAddr), .PCAddResult(tempAddr), .Rst(Rst), .Clk(Clk), .instruct(EXInstruct[25:0]), .ReadData1(MEMData1), .Branch(Branch), .PCWrite(PCWrite));
    
    // Takes PC and outputs an instruction
    instrMemory instructions(.readAddr(tempAddr), .Instruction(inInstr)); 
    
    ////////////////////////////////////////////////////////
    // module pipelineIFID(Clk, inInstr, outInstr, hazardIFDWrite, hazardIFFlush);
    ////////////////////////////////////////////////////////
    pipelineIFID pipeIFID(.Clk(Clk), .inInstr(inInstr), .outInstr(instr), .hazardIFDWrite(IFDWrite), .hazardIFFlush((Branch != 0)), .inPCCounter(tempAddr), .outPCCounter(DtempAddr));
    
    ////////////////////////////////////////////////////////
    // Decode Stage
    ////////////////////////////////////////////////////////
    
    // Hazard Unit
    hazardUnit hazarduntovictory(.Clk(Clk), .inMemRead(EXMemRead != 0), .inIDEXRt(EXRt), .inIFIDRs(instr[25:21]), .inIFIDRt(instr[20:16]),
                            .hazardPCWrite(PCWrite), .hazardIFIDWrite(IFDWrite), .hazardMux(hazardMux));
                        
    // Send Op Code into Controller
    Control mainController(.OpCode(instr[31:26]), .MemRead(MemRead), .MemWrite(MemWrite), .RegWrite(RegWrite), 
                .RegDestMux(RegDestMux), .MemToRegMux(MemToRegMux), 
                .ALUSrc1Mux(ALUSrc1Mux), .ALUOp(ALUOp));
                
    // Muxes for the control signals
    Mux1Bit2To1 muxIDRegWrite(.out(IDRegWrite), .inA(RegWrite), .inB(1'b0), .sel(hazardMux)); 
    Mux2Bit2To1 muxIDMemWrite(.out(IDMemWrite), .inA(MemWrite), .inB(2'b00), .sel(hazardMux));
    Mux2Bit2To1 muxIDMemRead(.out(IDMemRead), .inA(MemRead), .inB(2'b00), .sel(hazardMux));
     
    // Register File, change value in Clk to ClkDiv if demo on fpga
    RegisterFile mainRegister(.ReadRegister1(instr[25:21]), .ReadRegister2(instr[20:16]), 
                .WriteRegister(WBRegDest), .WriteData(RegWriteData), .RegWrite(WBRegWrite), 
                .Clk(Clk), .ReadData1(ReadData1), .ReadData2(ReadData2), .s1(s1), .s2(s2), .s3(s3), .s4(s4));
     // RegisterFile mainRegister(.WriteData(10), .Clk(Clk));
//   RegisterFile mainRegister(.ReadRegister1(instr[25:21]), .ReadRegister2(instr[20:16]), 
//              .WriteRegister(RegDest), .WriteData(RegWriteData), .RegWrite(RegWrite), 
//               .Clk(ClkOut), .ReadData1(ReadData1), .ReadData2(ReadData2));
    
    // Extends immediate value
    SignExtension signExtender(.in(instr[15:0]), .out(SignExtImmediate));
    
    ////////////////////////////////////////////////////////
    // module pipelineIDEX(Clk, inRs, inRt, inRd, inData1, inData2, inInstruct, inShamt, inImme,
    //                  outRs, outRt, outRd, outData1, outData2, outInstruct, outShamt, outImme,
    //                  inHazardRegWrite, inHazardALUSrc1Mux, inHazardMemRead, inHazardMemWrite, inHazardRegDestMux, inHazardMemToRegMux, inHazardALUOp,
    //                  outHazardRegWrite, outHazardALUSrc1Mux, outHazardMemRead, outHazardMemWrite, outHazardRegDestMux, outHazardMemToRegMux, outHazardALUOp);
    ////////////////////////////////////////////////////////
    pipelineIDEX pipeIDEX(.Clk(Clk), .inRs(instr[25:21]), .inRt(instr[20:16]), .inRd(instr[15:11]), .inData1(ReadData1), .inData2(ReadData2), .inInstruct(instr),  .inShamt(instr[10:6]), .inImme(SignExtImmediate), .inALUOP(ALUOp), .inHazard(hazardMux), .inPCCounter(DtempAddr),
                        .outRs(EXRs), .outRt(EXRt), .outRd(EXRd), .outData1(EXData1), .outData2(EXData2), .outInstruct(EXInstruct), .outShamt(EXShamt), .outImme(EXImme), .outALUOP(EXALUOP), .outPCCounter(EXtempAddr),
                        .inHazardRegWrite(IDRegWrite), .inHazardALUSrc1Mux(ALUSrc1Mux), .inHazardMemRead(IDMemRead), .inHazardMemWrite(IDMemWrite), .inHazardRegDestMux(RegDestMux), .inHazardMemToRegMux(MemToRegMux), .inHazardALUOp(ALUOp), .inHazardFlush(Branch != 0),
                        .outHazardRegWrite(EXRegWrite), .outHazardALUSrc1Mux(EXALUSrc1Mux), .outHazardMemRead(EXMemRead), .outHazardMemWrite(EXMemWrite), .outHazardRegDestMux(EXRegDestMux), .outHazardMemToRegMux(EXMemToRegMux), .outHazardALUOp(EXALUOp));

    ////////////////////////////////////////////////////////
    // Execution Stage
    ////////////////////////////////////////////////////////       
         
    // Mux Forward A
    Mux32Bit4To1 muxALU1(.out(ALUIn1), .inA(EXData1), .inB(MEMALUResult), .inC(WBALUResult), .inD(WBMemoryData), .sel(ForwardA));
    // Mux Forward B
    Mux32Bit4To1 muxALU2(.out(ALUInTemp), .inA(EXData2), .inB(MEMALUResult), .inC(WBALUResult), .inD(WBMemoryData), .sel(ForwardB));
    // Mux between regData or Immediate
    Mux32Bit2To1 ALUSrcMux(.out(ALUIn2), .inA(ALUInTemp), .inB(EXImme), .sel(EXALUSrc1Mux));
    // Mux to choose writing destination, 0 = A, 1 = B, will need a 32bit 4:1 mux later ("2bitmux" in your naming convention)
    Mux5Bit4To1 muxRegDest(.out(RegDest), .inA(EXRt), .inB(EXRd), .inC(5'd31), .inD(5'd0), .sel(EXRegDestMux));
                        
    // ALU Control
    ALUControl controlALU1(.instr(EXInstruct), .ALUOp(EXALUOP), .funct(EXInstruct[5:0]), .ALUControl(ALUControl));
    
    // ALU w/ Pipeline
    ALU32Bit firstALU(.ALUControl(ALUControl), .shamt(EXShamt), .A(ALUIn1), .B(ALUIn2), .ALUResult(ALUResult), .Zero(Zero), .Clk(Clk), .Branch(Branch));

    // Forward Unit
    forwardUnit forwardsuntovictory(.IDEXRs(EXRs), .IDEXRt(EXRt), .IDEXRd(EXRd), .EXMEMRd(MEMRegDest), .MEMWBRt(WBRt), .MEMWBRd(WBRegDest), .EXALUSrc1Mux(EXALUSrc1Mux),
                                    .memwrite(MEMMemRead), .WBmemwrite(WBMemRead), .regwrite(MEMRegWrite), .WBregwrite(WBRegWrite), .ALUMuxRs(ForwardA), .ALUMuxRt(ForwardB));
         
    // ALU itself OLD PRE-PIPELINE ALU
    //ALU32Bit firstALU(.ALUControl(ALUControl), .shamt(instr[10:6]), .A(ReadData1), .B(ALUIn1), .ALUResult(ALUResult), .Zero(Zero), .Clk(Clk), .Branch(Branch));
    //ALU32Bit firstALU(.ALUControl(ALUControl), .shamt(instr[10:6]), .A(ReadData1), .B(ALUIn1), .ALUResult(ALUResult), .Zero(Zero), .Clk(ClkOut), .Branch(Branch));
    
    ////////////////////////////////////////////////////////
    // module pipelineEXMEM(Clk, inRegDest, inALUResult, inData2, inRd, inRt,
    //                      outRegDest, outALUResult, outData2,outRd, outRt,
    //                      inHazardRegWrite, inHazardMemRead, inHazardMemWrite,  inHazardMemToRegMux,
    //                      outHazardRegWrite, outHazardMemRead, outHazardMemWrite,  outHazardMemToRegMux);
    ////////////////////////////////////////////////////////
    pipelineEXMEM pipeEXMEM(.Clk(Clk), .inRegDest(RegDest), .inALUResult(ALUResult), .inData2(ALUInTemp), .inRd(EXInstruct[15:11]), .inRt(EXRt), .inData1(EXData1), .inPCCounter(EXtempAddr),
                            .outRegDest(MEMRegDest), .outALUResult(MEMALUResult), .outData2(MEMData2), .outRd(MEMRd), .outRt(MEMRt), .outData1(MEMData1), .outPCCounter(MEMtempAddr),
                            .inHazardRegWrite(EXRegWrite), .inHazardMemRead(EXMemRead), .inHazardMemWrite(EXMemWrite),  .inHazardMemToRegMux(EXMemToRegMux),
                            .outHazardRegWrite(MEMRegWrite), .outHazardMemRead(MEMMemRead), .outHazardMemWrite(MEMMemWrite),  .outHazardMemToRegMux(MEMMemToRegMux));
    
    ////////////////////////////////////////////////////////
    // Memory Stage
    ////////////////////////////////////////////////////////
                            
    DataMemory mainMemory(.Address(MEMALUResult), .WriteData(MEMData2), .Clk(Clk), .MemWrite(MEMMemWrite), .MemRead(MEMMemRead), .ReadData(MemoryData)); 
    //DataMemory mainMemory(.Address(ALUResult), .WriteData(ReadData2), .Clk(ClkOut), .MemWrite(MemWrite), .MemRead(MemRead), .ReadData(MemoryData)); 
    
    ////////////////////////////////////////////////////////
    // module pipelineMEMWB(Clk, inRegDest, inMemData, inALUResult, inRd, inRt,
    //                      outRegDest, outMemData, outALUResult, outRd, outRt,
    //                      inHazardRegWrite, inHazardMemToRegMux,
    //                      outHazardRegWrite, outHazardMemToRegMux);
    ////////////////////////////////////////////////////////
    pipelineMEMWB pipeMEMWB(.Clk(Clk), .inRegDest(MEMRegDest), .inMemData(MemoryData), .inALUResult(MEMALUResult), .inRd(MEMRd), .inRt(MEMRt), .inData1(MEMData1), .inPCCounter(MEMtempAddr), .inMemRead(MEMMemRead),
                            .outRegDest(WBRegDest), .outMemData(WBMemoryData), .outALUResult(WBALUResult), .outRd(WBRd), .outRt(WBRt), .outData1(WBData1), .outPCCounter(WBtempAddr), .outMemRead(WBMemRead),
                            .inHazardRegWrite(MEMRegWrite), .inHazardMemToRegMux(MEMMemToRegMux),
                            .outHazardRegWrite(WBRegWrite), .outHazardMemToRegMux(WBMemToRegMux));
    
    ////////////////////////////////////////////////////////
    // Write Back Stage
    ////////////////////////////////////////////////////////
    
    // Write Data Mux
    Mux32Bit8To1 muxWriteData(.out(RegWriteData), .inA(WBALUResult), .inB(WBData1), .inC(Zero), .inD(WBMemoryData),
                .inE(WBtempAddr + 4), .inF(32'd0), .inG(32'd0), .inH(32'd0), .sel(WBMemToRegMux));
        
    ////////////////////////////////////////////////////////
    // End of Datapath
    ////////////////////////////////////////////////////////
    
    // When RegWriteData changes, update.
    always @ (RegWriteData) begin
        out <= RegWriteData;
    end
    always @ (tempAddr) begin
        ProgramCounter <= tempAddr;
    end
endmodule
