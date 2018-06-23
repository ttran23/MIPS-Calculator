`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - ALU32Bit.v
// Description - 32-Bit wide arithmetic logic unit (ALU).
//
// INPUTS:-
// ALUControl: 4-Bit input control bits to select an ALU operation.
// A: 32-Bit input port A.
// B: 32-Bit input port B.
//
// OUTPUTS:-
// ALUResult: 32-Bit ALU result output.
// ZERO: 1-Bit output flag. 
//
// FUNCTIONALITY:-
// Design a 32-Bit ALU behaviorally, so that it supports addition,  subtraction,
// AND, OR, and set on less than (SLT). The 'ALUResult' will output the 
// corresponding result of the operation based on the 32-Bit inputs, 'A', and 
// 'B'. The 'Zero' flag is high when 'ALUResult' is '0'. The 'ALUControl' signal 
// should determine the function of the ALU based on the table below:-
// Op   | 'ALUControl' value
// ==========================
// SUB  | 0110
// AND  | 0000
// OR   | 0001
// SLT  | 0111
//
// NOTE:-
// SLT (i.e., set on less than): ALUResult is '32'h000000001' if A < B.
// 
////////////////////////////////////////////////////////////////////////////////

module ALU32Bit(ALUControl, shamt, A, B, ALUResult, Zero, Clk, Branch);

	input [5:0] ALUControl; // control bits for ALU operation
	input [4:0] shamt;
	input [31:0] A, B;	    // inputs
	input Clk;

	output [31:0] ALUResult;	// answer
	output Zero;	    // Zero=1 if ALUResult == 0
	output reg [1:0] Branch = 0;
	reg [31:0] Hi, Lo;
    
    /* Please fill in the implementation here... */
    //wire signed [31:0] singed_A;
    //wire signed [31:0] signed_B;
    
    //assign signed_A = A;
    //assign signed_B = B;
    
    reg [31:0] ALUResult;
    reg [63:0] tempALUResult;
    reg [31:0] temp;
    reg Zero;
    reg [4:0] i;
    
    /*
    00000	 AND/ANDI           10000   OR/ORI
    00001    XOR/XORI           10001   NOR
    00010    Addu/Addiu         10010   Add/Addi
    00011    Sub                10011   Mul(signed??)
    00100    MULT               10100   MULTU
    00101    MADD               10101   MSUB
    00110    SLL                10110   SLLV
    00111    SRL                10111   SRLV
    01000    SLTU               11000   SLT
    01001    MOVZ               11001   MOVN
    01010    ROTR               11010   ROTRV
    01011    SRA                11011   SRAV
    01100    SEH                11100   
    01101    MTHI               11101   MTLO
    01110    MFHI               11110   MFLO
    01111                       11111
    */
    
    always @ (*)
    begin
        Branch = 0;
        tempALUResult <= 0;
        case(ALUControl)
            6'b000000:   // AND/ANDI
            begin
                ALUResult <= A & B;
            end
            
            6'b100000:   // OR/ORI signed
            begin
                ALUResult <= A | B;
            end
                        
            6'b000001:   // XOR/XORI
            begin
                ALUResult <= A ^ B;
            end
            
            6'b100001:   // NOR
            begin
                ALUResult <= ~(A | B);
            end
            
            6'b000010:   // Add/Addi unsigned
            begin
                ALUResult <= A + B;
            end
            
            6'b100010:   // Add/Addi signed
            begin
                ALUResult <= $signed(A) + $signed(B);
            end            
            
            6'b000011:   // Sub, doesn't matter if signed or signed
            begin
                ALUResult <= A - B;
            end
            
            6'b100011:   // MUL
            begin
                tempALUResult <= $signed(A) * $signed(B);
                ALUResult <= tempALUResult[31:0];
            end
            
            6'b000100:   // MULTU Unsigned
            begin
                tempALUResult <= A * B;
                ALUResult <= 0;
                //Hi <= tempALUResult[63:32];
                //Lo <= tempALUResult[31:0];
            end
            
            6'b100100:   // MULT Signed
            begin
                tempALUResult <= $signed(A) * $signed(B);
                ALUResult <= 0;
                //Hi <= tempALUResult[63:32];
                //Lo <= tempALUResult[31:0];
            end
            
            6'b000101:   // MAdd
            begin
                tempALUResult <= $signed({Hi,Lo}) + {A[31] + B[31], A * B};
                ALUResult <= 0;
                //Hi <= tempALUResult[63:32];
                //Lo <= tempALUResult[31:0];
            end
            
            6'b100101:   // MSub
            begin
                  tempALUResult <= $signed({Hi,Lo}) - {A[31] + B[31], A * B};
                  ALUResult <= 0;
                  //Hi <= tempALUResult[63:32];
                  //Lo <= tempALUResult[31:0];
            end
            
            6'b000110:   // SLL
            begin
                ALUResult <= B << shamt;
            end
            
            6'b100110:   // SLLV
            begin
                ALUResult <= B << A[4:0];
            end
            
            6'b000111:   // SRL
            begin
                ALUResult <= B >> shamt;
            end
            
            6'b100111:   // SRLV
            begin
                ALUResult <= B >> A[4:0];
            end
            
            6'b001000:   // SLTU/SLTIU unsigned
            begin
                if (A < B)
                    begin
                        ALUResult <= 32'd1;
                    end
                else
                    begin
                        ALUResult <= 32'd0;
                    end
            end
            
            6'b101000:   // SLT/SLTI signed
            begin
                if ($signed(A) < $signed(B))
                    begin
                        ALUResult <= 32'd1;
                    end
                else
                    begin
                        ALUResult <= 32'd0;
                    end
            end
            
            6'b001001:   // MOVZ move on zero  
            begin
                if (B == 0)
                    begin
                        ALUResult <= A;
                    end
                else 
                    begin
                        ALUResult <= 0; //jank ass solution but w/e
                    end
            end
            
            6'b101001:   // MOVN move on NOT zero
            begin
                if (B != 0)
                    begin
                        ALUResult <= A;
                    end
                else
                    begin
                        ALUResult <= 0; //jank ass solution but w/e
                    end
            end
            
            6'b001010:   // ROTR rotate right 
            begin
//                tempALUResult <= {B, B};
//                tempALUResult <= tempALUResult >> shamt;
//                ALUResult <= tempALUResult[31:0];
                //temp <= B << (32 - shamt);
                ALUResult <= ((B << (32 - shamt)) | (B >> shamt));
            end
            
            6'b101010:   // ROTRV rotate right variable
            begin
//                tempALUResult <= {B, B};
//                tempALUResult <= tempALUResult >> A[4:0];
//                ALUResult <= tempALUResult[31:0];
                  ALUResult <= ((B << (32 - A[4:0])) | (B >> A[4:0]));
                //temp <= B << (32 - (A[4:0] + 1));
                //ALUResult <= (temp | (B >> shamt));
            end
            
            6'b001011:   // SRA
            begin
                //sign <= B[31];
                //ALUResult <= B >> shamt;
                //ALUResult[31] <= sign;
                
                //OR (according to Google)
                
                ALUResult <= B >>> shamt;
                //for(i = 31; i > (31 - shamt); i = i - 1) begin
                //     ALUResult[i] = 1;
                //end 
                
                //apparently there's a way to do arithmetic shift using an operator in verilog. 
                //vivado throws syntax errors if you try to use it. GG
                
            end
            
            6'b101011:   // SRAV
            begin
                //sign <= B[31];
                //ALUResult <= B >> A[4:0];
                //ALUResult[31] <= sign;
                
                //OR (according to Google)
              
                ALUResult <= $signed(B) >>> A[4:0];
                //for(i = 31; i > (31 - A[4:0]); i = i - 1) begin
                //     ALUResult[i] = 1;
               //end
            end
            
            6'b001100:   // SEH/SEB
            begin
            // { {16{in[15]}}, in[15:0] }
                if (shamt == 6'b11000)  // SEH
                    begin
                        ALUResult <= { {16{B[15]}}, B[15:0] };
                    end
                else if (shamt == 6'b10000) // SEB
                    begin
                        ALUResult <= { {24{B[7]}}, B[7:0] };
                    end
                else
                    begin
                        ALUResult <= 0;
                    end
            end
            
            6'b101100:   // Load Upper Immediate
            begin
                ALUResult <= $signed({ B[15:0], 16'b0});
                //ALUResult <= {(temp[31:16]), 16'd0};
            end
            
            6'b001101:   // MTHI
            begin
                tempALUResult[63:32] <= A;
                ALUResult <= 0;
            end
            
            6'b101101:   // MTLO
            begin
                tempALUResult[31:0] <= A;
                ALUResult <= 0;
            end
            
            6'b001110:   // MFHI
            begin
                ALUResult <= Hi;
            end
            
            6'b101110:   // MFLO
            begin
                ALUResult <= Lo;
            end
            
            6'b001111:   // BEQ
            begin
                ALUResult <= 0;
                if (A == B) Branch = 1;
            end
            
            6'b101111:   // BNE
            begin
                ALUResult <= 0;
               if (A != B) Branch = 1;
            end
            
            6'b010000:   // BGEZ (branch on greater than or equal to zero)
            begin
                ALUResult <= 0;
                if ($signed(A) >= 0) Branch = 1;
            end
            
            6'b110000:   // BGTZ (branch on greater than zero)
            begin
                ALUResult <= 0;
                if ($signed(A) > 0) Branch = 1;
            end
            
            6'b010001:   // BLEZ (branch on less than or equal to zero)
            begin
                ALUResult <= 0;
                if ($signed(A) <= 0)  Branch = 1;
            end
            
            6'b110001:   // BLTZ (branch on less than zero)
            begin
                ALUResult <= 0;
                if ($signed(A) < 0) Branch = 1;
            end
            
            6'b010010:   //jump/jal
            begin
                ALUResult <= 0;
                Branch = 3;
            end
            
            6'b110010:   //jr
            begin
                ALUResult <= A;
                Branch = 2;
            end
            
            
            default:    // Should never get here, but whatever.
            begin
                ALUResult <= 0;
            end
        endcase
        
        //flagging zero output
        if (ALUResult == 0)
            Zero <= 1;
        else
            Zero <= 0;
    end
    always @ (posedge Clk) begin
    if (tempALUResult != 0) begin
        Hi <= tempALUResult[63:32];
        Lo <= tempALUResult[31:0];
        end
    end

endmodule
