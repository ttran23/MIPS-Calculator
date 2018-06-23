`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Arizona
// Engineer: Tam Tran, Rohin Galhotra
// 
// Create Date: 10/10/2016 09:00:59 AM
// Module Name: Control
//////////////////////////////////////////////////////////////////////////////////


module Control(OpCode, MemRead, MemWrite, RegWrite, 
                RegDestMux, MemToRegMux, 
                ALUSrc1Mux, ALUOp);
    
    input [5:0] OpCode;
    output reg RegWrite;
    output reg ALUSrc1Mux; 
    output reg [1:0] RegDestMux, MemRead, MemWrite;
    output reg [2:0] MemToRegMux;
    output reg [4:0] ALUOp;
    
    /*
    MemRead, MemWrite, RegWrite: 0 = off, 1 = on
    ALUSrc1Mux: 0 = rt, 1 = immediate value
    RegDestMux: 0 = rt, 1 = rd, 2 = 31bit thing, 3 = unused
    MemToRegMux: 0 = ALU1Result, 1 = MemReadData, 2 = rs, 3 = ShiftVal from something, 4 = add 4??, 5 = ALU Zero flag 
    ALUOp: Identifiers for ALUController
    */
    
    always @(OpCode)
    begin
        case(OpCode)
            // "SPECIAL" opcode
            // Add (signed), Add (unsigned), Subtract (signed), Multiply Word (signed), Multiply Word (unsigned)
            // AND, OR, NOR, XOR, Shift Left SLL, Shift Left Var SLLV, Shift Right SRL, Shift Right Var SRLV
            // SLT (signed), SLTU unsigned), Move Cond. Zero MOVZ, Move Cond. NZero MOVN
            // Shift Right Arithmetic SRA, Shift Right Variable SRAV, 
            // ROTR (has 00001 in rs field), ROTRV (has 00001 in sa field)
            6'b000000:  //ALUOp = 0
            begin
                RegDestMux <= 2'b01;    // Choose: rd
                ALUSrc1Mux <= 0;        // Choose: rt
                ALUOp <= 5'b00000;      // 
                MemRead <= 0;           // Not reading memory
                MemWrite <= 0;          // Not writing memory
                MemToRegMux <= 3'b000;  // Choose: ALU output
                RegWrite <= 1;          // Write to Register
            end
            
            // "SPECIAL2" opcodes
            // Multiply MUL (32 least sig bit), MADD, MSUB
            6'b011100:  //ALUOp = 1
            begin
                RegDestMux <= 2'b01;    // Choose: rd (rd = 0 for MADD/MSUB)
                ALUSrc1Mux <= 0;        // Choose: rt
                ALUOp <= 5'b00001;      // 
                MemRead <= 0;           // Not reading memory
                MemWrite <= 0;          // Not writing memory
                MemToRegMux <= 3'b000;  // Choose: ALU output for MUL -> rd, MAdd/MSub HiLo stay in ALU
                RegWrite <= 1;          // Write to Register
            end
            
            // "SPECIAL3" opcodes
            // Sign Extend Half SEH, Sign Extend Byte SEB
            // FIXME FIXME FIXME FIXME FIXME FIXME@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
            6'b011111:  //ALUOp = 2
            begin
                RegDestMux <= 2'b01;    // Choose: rd
                ALUSrc1Mux <= 0;        // Choose: rt
                ALUOp <= 5'b00010;      // 
                MemRead <= 0;           // Not reading memory
                MemWrite <= 0;          // Not writing memory
                MemToRegMux <= 3'b000;  // Choose: ALU output
                RegWrite <= 1;          // Write to Register
            end
            
            // Add Immediate Signed
            6'b001000:  //ALUOp = 3
            begin
                RegDestMux <= 2'b00;    // Choose: rt
                ALUSrc1Mux <= 1;        // Choose: imme
                ALUOp <= 5'b00011;      // 
                MemRead <= 0;           // Not accessing memory
                MemWrite <= 0;          // Not writing memory
                MemToRegMux <= 3'b000;  // Choose: ALU output
                RegWrite <= 1;          // Write to Register
            end
            
            // Add Immediate Unsigned
            6'b001001:  //ALUOp = 4
            begin
                RegDestMux <= 2'b00;    // Choose: rt
                ALUSrc1Mux <= 1;        // Choose: imme
                ALUOp <= 5'b00100;      // 
                MemRead <= 0;           // Not accessing memory
                MemWrite <= 0;          // Not writing memory
                MemToRegMux <= 3'b000;  // Choose: ALU output
                RegWrite <= 1;          // Write to Register
            end
            
            //AND Immediate
            6'b001100:  //ALUOp = 5
            begin
                RegDestMux <= 2'b00;    // Choose: rt
                ALUSrc1Mux <= 1;        // Choose: imme
                ALUOp <= 5'b00101;      //
                MemRead <= 0;           // Not accessing memory
                MemWrite <= 0;          // Not writing memory
                MemToRegMux <= 3'b000;  // Choose: ALU output
                RegWrite <= 1;          // Write to Register
            end
            
            //OR Immediate
            6'b001101:  //ALUOp = 6
            begin
                RegDestMux <= 2'b00;    // Choose: rt
                ALUSrc1Mux <= 1;        // Choose: imme
                ALUOp <= 5'b00110;      // 
                MemRead <= 0;           // Not accessing memory
                MemWrite <= 0;          // Not writing memory
                MemToRegMux <= 3'b000;  // Choose: ALU output
                RegWrite <= 1;          // Write to Register
            end
            
            //XOR Immediate
            6'b001110:  //ALUOp = 7
            begin
                RegDestMux <= 2'b00;    // Choose: rt
                ALUSrc1Mux <= 1;        // Choose: imme
                ALUOp <= 5'b00111;      // 
                MemRead <= 0;           // Not accessing memory
                MemWrite <= 0;          // Not writing memory
                MemToRegMux <= 3'b000;  // Choose: ALU output
                RegWrite <= 1;          // Write to Register
            end
           
            //Set Less Than Immediate
            6'b001010:  //ALUOp = 8
            begin
                RegDestMux <= 2'b00;    // Choose: rt
                ALUSrc1Mux <= 1;        // Choose: imme
                ALUOp <= 5'b01000;      // 
                MemRead <= 0;           // Not accessing memory
                MemWrite <= 0;          // Not writing memory
                MemToRegMux <= 3'b000;  // Choose: ALU output
                RegWrite <= 1;          // Write to Register
            end
                        
            //Set Less Than Immediate (Unsigned)
            6'b001011:  //ALUOp = 9
            begin
                RegDestMux <= 2'b00;    // Choose: rt
                ALUSrc1Mux <= 1;        // Choose: imme
                ALUOp <= 5'b01001;      // 
                MemRead <= 0;           // Not accessing memory
                MemWrite <= 0;          // Not writing memory
                MemToRegMux <= 3'b000;  // Choose: ALU output
                RegWrite <= 1;          // Write to Register
            end
            
            //////////////////////////////////////////////////////////////
            // FIXME FIXME FIXME
            // NEED TO DOUBLE CHECK MemToRegMux so that LW writes to
            // Should we just use the add operation? since its' base + offset
            // the output that comes out of DataMemory
            //////////////////////////////////////////////////////////////
            
            //Load Upper Immediate, either have its own or send through left shift n concatenate
            6'b001111:
            begin
                RegDestMux <= 2'b00;    // Choose: rt
                ALUSrc1Mux <= 1;        // Choose: imme
                ALUOp <= 5'b01010;      // 
                MemRead <= 0;           // Not accessing memory
                MemWrite <= 0;          // Not writing memory
                MemToRegMux <= 3'b000;  // Choose: ALU output
                RegWrite <= 1;          // Not writing to Register
            end
            
            //Branch on Equal (BEQ)
            6'b000100:
            begin //below is copypasta so ignore some of the values
                RegDestMux <= 2'b00;    // Choose: who cares
                ALUSrc1Mux <= 0;        // Choose: rt
                ALUOp <= 5'b01011;      // 
                MemRead <= 0;           // Not accessing memory
                MemWrite <= 0;          // Not writing memory
                MemToRegMux <= 3'b000;  // Choose: ALU output
                RegWrite <= 0;          // Not writing to Register    
            end
            
            //Branch on NOT Equal (BNE)
            6'b000101:
            begin //below is copypasta so ignore some of the values
                RegDestMux <= 2'b00;    // Choose: who cares
                ALUSrc1Mux <= 0;        // Choose: rt
                ALUOp <= 5'b01100;      // 
                MemRead <= 0;           // Not accessing memory
                MemWrite <= 0;          // Not writing memory
                MemToRegMux <= 3'b000;  // Choose: ALU output
                RegWrite <= 0;          // Not writing to Register    
            end
            
            //Branch if Greater than zero
            6'b000111:
            begin //below is copypasta so ignore some of the values
                RegDestMux <= 2'b00;    // Choose: who cares
                ALUSrc1Mux <= 0;        // Choose: rt
                ALUOp <= 5'b01101;      // 
                MemRead <= 0;           // Not accessing memory
                MemWrite <= 0;          // Not writing memory
                MemToRegMux <= 3'b000;  // Choose: ALU output
                RegWrite <= 0;          // Not writing to Register    
            end
            
            // "REGIMM", has BGEZ (rt == 1) and BLTZ (rt == 0)
            6'b000001:
            begin //below is copypasta so ignore some of the values
                RegDestMux <= 2'b00;    // Choose: who cares
                ALUSrc1Mux <= 0;        // Choose: rt
                ALUOp <= 5'b01110;      // 
                MemRead <= 0;           // Not accessing memory
                MemWrite <= 0;          // Not writing memory
                MemToRegMux <= 3'b000;  // Choose: ALU output
                RegWrite <= 0;          // Not writing to Register    
            end
            
            //Branch if less than or equal to zero
            6'b000110:
            begin //below is copypasta so ignore some of the values
                RegDestMux <= 2'b00;    // Choose: who cares
                ALUSrc1Mux <= 0;        // Choose: rt
                ALUOp <= 5'b01111;      // 
                MemRead <= 0;           // Not accessing memory
                MemWrite <= 0;          // Not writing memory
                MemToRegMux <= 3'b000;  // Choose: ALU output
                RegWrite <= 0;          // Not writing to Register    
            end
            
            // Jump
            6'b000010:
            begin //below is copypasta so ignore some of the values
                RegDestMux <= 2'b00;    // Choose: who cares
                ALUSrc1Mux <= 0;        // Choose: doesn't matter
                ALUOp <= 5'b10000;      // 
                MemRead <= 0;           // Not accessing memory
                MemWrite <= 0;          // Not writing memory
                MemToRegMux <= 3'b000;  // Choose: ALU output
                RegWrite <= 0;          // Not writing to Register    
            end
            
            // Jump and Link
            6'b000011:
            begin //below is copypasta so ignore some of the values
                RegDestMux <= 2'b10;    // Choose: reg 31
                ALUSrc1Mux <= 0;        // Choose: doesn't matter
                ALUOp <= 5'b10001;      // 
                MemRead <= 0;           // Not accessing memory
                MemWrite <= 0;          // Not writing memory
                MemToRegMux <= 3'b100;  // Choose: tempAddr + 8
                RegWrite <= 1;          // Writing to Register    
            end
             
            //Load Word
            6'b100011:
            begin
                RegDestMux <= 2'b00;    // Choose: rt
                ALUSrc1Mux <= 1;        // Choose: imme
                ALUOp <= 5'b10010;      // Add unsigned (base + offset)
                MemRead <= 1;           // Accessing memory
                MemWrite <= 0;          // Not writing memory
                MemToRegMux <= 3'b011;  // Choose: Memory output
                RegWrite <= 1;          // Write to Register
            end
            
            //Load Byte (signed)
            6'b100000:
            begin
                RegDestMux <= 2'b00;    // Choose: rt
                ALUSrc1Mux <= 1;        // Choose: imme
                ALUOp <= 5'b10010;      // Add unsigned (base + offset)
                MemRead <= 2;           // Accessing memory
                MemWrite <= 0;          // Not writing memory
                MemToRegMux <= 3'b011;  // Choose: Memory output
                RegWrite <= 1;          // Write to Register
            end
            
            //Load Half
            6'b100001:
            begin
                RegDestMux <= 2'b00;    // Choose: rt
                ALUSrc1Mux <= 1;        // Choose: imme
                ALUOp <= 5'b10010;      // Add unsigned (base + offset)
                MemRead <= 3;           // Accessing memory
                MemWrite <= 0;          // Not writing memory
                MemToRegMux <= 3'b011;  // Choose: Memory output
                RegWrite <= 1;          // Write to Register
            end
            
            //Store Word
            6'b101011:
            begin
                RegDestMux <= 2'b00;    // Choose: rt
                ALUSrc1Mux <= 1;        // Choose: imme
                ALUOp <= 5'b10010;      // Add unsigned (base + offset)
                MemRead <= 0;           // Not accessing memory
                MemWrite <= 1;          // Writing memory
                MemToRegMux <= 3'b000;  // Choose: 
                RegWrite <= 0;          // Not writing to Register
            end
            
            //Store Byte
            6'b101000:
            begin
                RegDestMux <= 2'b00;    // Choose: rt
                ALUSrc1Mux <= 1;        // Choose: imme
                ALUOp <= 5'b10010;      // Add Unsigned (base + offset)
                MemRead <= 0;           // Not accessing memory
                MemWrite <= 2;          // Writing memory
                MemToRegMux <= 3'b000;  // Choose: 
                RegWrite <= 0;          // Not writing to Register
            end
            
            //Store Half
            6'b101001:
            begin
                RegDestMux <= 2'b00;    // Choose: rt
                ALUSrc1Mux <= 1;        // Choose: imme
                ALUOp <= 5'b10010;      // Add Unsigned (base + offset)
                MemRead <= 0;           // Not accessing memory
                MemWrite <= 3;          // Writing memory
                MemToRegMux <= 3'b000;  // Choose: 
                RegWrite <= 0;          // Not writing to Register  
            end  
             
            //default
            default:    //ALUOP = 11111
            begin
                RegDestMux <= 2'b11;    //choose rd as destination
                ALUSrc1Mux <= 0;        //want rt, not imme
                ALUOp <= 5'b11111;      //choose ALU operation
                MemRead <= 0;           //not accessing memory
                MemWrite <= 0;          //not writing memory
                MemToRegMux <= 3'b111;  //not using memory output, alu1 output
                RegWrite <= 1;          // Write to Register
            end
        endcase
    end
    
endmodule
