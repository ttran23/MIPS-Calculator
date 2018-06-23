`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// Laboratory  
// Module - PCAdder.v
// Description - 32-Bit program counter (PC) adder.
// 
// INPUTS:-
// PCResult: 32-Bit input port.
// 
// OUTPUTS:-
// PCAddResult: 32-Bit output port.
//
// FUNCTIONALITY:-
// Design an incrementor (or a hard-wired ADD ALU whose first input is from the 
// PC, and whose second input is a hard-wired 4) that computes the current 
// PC + 4. The result should always be an increment of the signal 'PCResult' by 
// 4 (i.e., PCAddResult = PCResult + 4).
////////////////////////////////////////////////////////////////////////////////

module PCAdder(PCResult, PCAddResult, Rst, Clk, instruct, ReadData1, Branch, PCWrite);

    input [31:0] PCResult;
    input Rst, Clk, PCWrite;
    (* mark_debug = "true" *) input [25:0] instruct;  
    input [31:0] ReadData1;
    input [1:0] Branch;

    output [31:0] PCAddResult;
    
    reg [31:0] PCAddResult;
    

    /* Please fill in the implementation here... */
        always @ (posedge Clk, posedge Rst) begin //FIXME?
            if (Rst == 1) begin
                PCAddResult <= -4;
            end
            else begin  
                if (~PCWrite) begin  
                    if (Branch == 1) begin
                        //PCAddResult <= (PCResult) + (instruct[15:0] <<< 2) + 4;
                        PCAddResult <= (PCResult) + (instruct[15:0] <<< 2) - 4;
                    end
                    else if (Branch == 2) begin
                        PCAddResult <= ReadData1;
                    end
                    else if (Branch == 3) begin
                        PCAddResult <= instruct << 2;
                    end
                    else begin
                        PCAddResult <= PCResult + 4;
                    end
                end
                else PCAddResult <= PCResult;
            end
        end 
endmodule

