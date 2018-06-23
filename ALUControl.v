`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Arizona
// Engineer: Tam Tran, Rohin Galhotra
// 
// Create Date: 10/10/2016 08:53:29 AM
// Module Name: ALUControl
//////////////////////////////////////////////////////////////////////////////////


module ALUControl(instr, ALUOp, funct, ALUControl);

    input [31:0] instr;
    input [4:0] ALUOp;
    input [5:0] funct;
    
    output reg [5:0] ALUControl;
    
    
    always @(*)
    begin
        ALUControl <= 6'b11111;
        case(ALUOp)
            5'b00000:   // "SPECIAL" opcodes
            begin
                //case (funct)
                    if(funct == 6'b100000)  // Add signed
                    begin
                        ALUControl <= 6'b100010;
                    end
                    
                    if(funct == 6'b100001)  // Add unsigned
                    begin
                        ALUControl <= 6'b000010;
                    end
                    
                    if(funct == 6'b100010)  // Subtract signed
                    begin
                        ALUControl <= 6'b000011;
                    end
                    
                    if(funct == 6'b011000)  // Multiply Word signed
                    begin
                        ALUControl <= 6'b100100;
                    end
                    
                    if(funct == 6'b011001)  // Multiply Word unsigned
                    begin
                        ALUControl <= 6'b000100;
                    end
                    
                    if(funct == 6'b100100)  //AND signed
                    begin
                        ALUControl <= 6'b000000;
                    end
                    
                    if(funct == 6'b100101)  //OR signed
                    begin
                        ALUControl <= 6'b100000;
                    end
                    
                    if(funct == 6'b100111)  //NOR signed
                    begin
                        ALUControl <= 6'b100001;
                    end
                    
                    if(funct == 6'b100110)  //XOR signed
                    begin
                        ALUControl <= 6'b000001;
                    end
                    
                    if(funct == 6'b000000)  //Shift Left Logical
                    begin
                        ALUControl <= 6'b000110;
                    end
                    
                    if(funct == 6'b000010)  //Shift Right Logical
                    begin
                        if (instr[25:21] == 1) begin
                            ALUControl <= 6'b001010;
                            end
                        else begin
                            ALUControl <= 6'b000111;
                        end
                    end
                    
                    if(funct == 6'b000100)  //Shift Left Logical Variable
                    begin
                        ALUControl <= 6'b100110;
                    end
                    
                    if(funct == 6'b000110)  //Shift Right Logical Variable
                    begin
                        if (instr[10:6] == 1) begin
                            ALUControl <= 6'b101010;
                        end
                        else begin
                            ALUControl <= 6'b100111;
                        end
                    end
                    
                    if(funct == 6'b101010)  //Set Less Than signed
                    begin
                        ALUControl <= 6'b101000;
                    end
                    
                    if(funct == 6'b101011)  //Set Less Than unsigned
                    begin
                        ALUControl <= 6'b001000;
                    end
                    
                    if(funct == 6'b001011)  //Move Conditional Not Zero
                    begin
                        ALUControl <= 6'b101001;
                    end
                    
                    if(funct == 6'b001010)  //Move Conditional Zero
                    begin
                        ALUControl <= 6'b001001;
                    end
                    
                    if(funct == 6'b000011)  //Shift Right Arithmetic
                    begin
                        ALUControl <= 6'b001011;
                    end
                    
                    if(funct == 6'b000111)  //Shift Right Arithmetic Variable
                    begin
                        ALUControl <= 6'b101011;
                    end
                    
                    if(funct == 6'b001000)  //Jump Register
                    begin
                        ALUControl <= 6'b110010;
                    end
                    ////////////////////////////////////////////
                    // PHASE 2
                    // LAB 14-15
                    ////////////////////////////////////////////
                    
                    //implement later
                    if(funct == 6'b010001)  // Move to Hi Register
                    begin
                        ALUControl <= 6'b001101;
                    end
                    
                    if(funct == 6'b010011)  // Move to Lo Register
                    begin
                        ALUControl <= 6'b101101;
                    end
                    
                    if(funct == 6'b010000)  // Move from Hi Register
                    begin
                        ALUControl <= 6'b001110;
                    end
                    
                    if(funct == 6'b010010)  // Move from Lo Register
                    begin
                        ALUControl <= 6'b101110;
                    end
                    
                    if(funct == 6'b001000)  // Jump Register
                    begin
                        ALUControl <= 6'b110010;
                    end
            end
            
            5'b00001:   // "SPECIAL2" opcode
            begin
                case (funct)
                    6'b000010:  // MUL
                    begin
                        ALUControl <= 6'b100011;
                    end
                    
                    6'b000000:  // MAdd
                    begin
                        ALUControl <= 6'b000101;
                    end
                    
                    6'b000100:  // MSub
                    begin
                        ALUControl <= 6'b100101;
                    end
                endcase
               // ALUControl <= 6'b010011;
            end
                        
            5'b00010:   // "SPECIAL3" opcode  SEH/SEB
            begin
                ALUControl <= 6'b001100;
            end
                        
            5'b00011:   // Add Immediate Signed
            begin
                ALUControl <= 6'b100010;
            end
                        
            5'b00100:   // Add Immediate Unsigned
            begin
                ALUControl <= 6'b000010;
            end
                        
            5'b00101:   // AND Immediate
            begin
                ALUControl <= 6'b000000;
            end
                        
            5'b00110:   // OR Immediate
            begin
                ALUControl <= 6'b100000;
            end

            5'b00111:   // XOR Immediate
            begin
                ALUControl <= 6'b000001;
            end
            
            5'b01000:   // SLT Immediate Signed
            begin
                ALUControl <= 6'b101000;
            end
                        
            5'b01001:   // SLT Immediate Unsigned
            begin
                ALUControl <= 6'b001000;
            end
            
            5'b01010:   // Load Upper Immediate
            begin
                ALUControl <= 6'b101100;
            end
            
            5'b01011:   // Branch Equal (BEQ)
            begin
                ALUControl <= 6'b001111;
            end
            
            5'b01100:   // Branch NOT Equal (BNE)
            begin
                ALUControl <= 6'b101111;
            end
            
            5'b01101:   // Branch Greater than Zero (BGTZ)
            begin
                ALUControl <= 6'b110000;
            end
            
            5'b01110:   // REGIMM, BGEZ (rt == 1) or BLTZ (rt == 0)
            begin
                if (instr[20:16] == 1)
                begin
                    ALUControl <= 6'b010000;
                end
                else if (instr[20:16] == 0)
                begin
                    ALUControl <= 6'b110001;
                end
                else
                begin
                    ALUControl <= 6'b111111; // throwaway
                end
            end
            
            5'b01111:   // Branch less than or Equal zero (BLEZ)
            begin
                ALUControl <= 6'b010001;
            end
            
            5'b10000:   // Jump
            begin 
                ALUControl <= 6'b010010; 
            end
            
            5'b10001:   // Jump and Link
            begin 
                ALUControl <= 6'b010010; 
            end
            
            5'b10010:   // Loads/Stores, since it's just an add operation
            begin 
                ALUControl <= 6'b000010; 
            end
            
            ////////////////////////////////////
            // Unused at the moment, but
            // there in case we need em
            //////////////////////////////////
            
            5'b10011: 
            begin 
                ALUControl <= 6'b111111; 
            end
            
            5'b10100: 
            begin 
                ALUControl <= 6'b111111; 
            end
            
            5'b10101: 
            begin 
                ALUControl <= 6'b111111; 
            end
            
            5'b10110: 
            begin 
                ALUControl <= 6'b111111; 
            end
            
            default:
            begin
                ALUControl <= 6'b111111;
            end
        endcase
    end
    
endmodule
