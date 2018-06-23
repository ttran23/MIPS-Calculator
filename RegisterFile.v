`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
//
//
// Student(s) Name and Last Name: FILL IN YOUR INFO HERE!
//
//  Tam Tran
//  Rohin Galhotra
//
// Module - register_file.v
// Description - Implements a register file with 32 32-Bit wide registers.
//
// 
// INPUTS:-
// ReadRegister1: 5-Bit address to select a register to be read through 32-Bit 
//                output port 'ReadRegister1'.
// ReadRegister2: 5-Bit address to select a register to be read through 32-Bit 
//                output port 'ReadRegister2'.
// WriteRegister: 5-Bit address to select a register to be written through 32-Bit
//                input port 'WriteRegister'.
// WriteData: 32-Bit write input port.
// RegWrite: 1-Bit control input signal.
//
// OUTPUTS:-
// ReadData1: 32-Bit registered output. 
// ReadData2: 32-Bit registered output. 
//
// FUNCTIONALITY:-
// 'ReadRegister1' and 'ReadRegister2' are two 5-bit addresses to read two 
// registers simultaneously. The two 32-bit data sets are available on ports 
// 'ReadData1' and 'ReadData2', respectively. 'ReadData1' and 'ReadData2' are 
// registered outputs (output of register file is written into these registers 
// at the falling edge of the clock). You can view it as if outputs of registers
// specified by ReadRegister1 and ReadRegister2 are written into output 
// registers ReadData1 and ReadData2 at the falling edge of the clock. 
//
// 'RegWrite' signal is high during the rising edge of the clock if the input 
// data is to be written into the register file. The contents of the register 
// specified by address 'WriteRegister' in the register file are modified at the 
// rising edge of the clock if 'RegWrite' signal is high. The D-flip flops in 
// the register file are positive-edge (rising-edge) triggered. (You have to use 
// this information to generate the write-clock properly.) 
//
// NOTE:-
// We will design the register file such that the contents of registers do not 
// change for a pre-specified time before the falling edge of the clock arrives 
// to allow for data multiplexing and setup time.
////////////////////////////////////////////////////////////////////////////////

module RegisterFile(ReadRegister1, ReadRegister2, WriteRegister, WriteData, RegWrite, Clk, ReadData1, ReadData2, s1, s2, s3, s4);
//module RegisterFile(WriteData, Clk,);

	/* Please fill in the implementation here... */
    input [4:0] ReadRegister1;
    input [4:0] ReadRegister2;
    input [4:0] WriteRegister;
    input [31:0] WriteData;
    input RegWrite;
    input Clk;
    
    
    (* mark_debug = "true" *) reg [63:0]registers [31:0];
    
    output wire[31:0] ReadData1;
    output wire[31:0] ReadData2;
    output wire[31:0] s1;
    output wire[31:0] s2;
    output wire[31:0] s3;
    output wire[31:0] s4;
    
    initial begin
        registers[0] = 0;
        registers[1] = 0;
        registers[2] = 0;
        registers[3] = 0;
        registers[4] = 0;
        registers[5] = 0;
        registers[6] = 0;
        registers[7] = 0;
        registers[8] = 0;
        registers[9] = 0;
        registers[10] = 0;
        registers[11] = 0;
        registers[12] = 0;
        registers[13] = 0;
        registers[14] = 0;
        registers[15] = 0;
        registers[16] = 0;
        registers[17] = 0;
        registers[18] = 0;
        registers[19] = 0;
        registers[20] = 0;
        registers[21] = 0;
        registers[22] = 0;
        registers[23] = 0;
        registers[24] = 0;
        registers[25] = 0;
        registers[26] = 0;
        registers[27] = 0;
        registers[28] = 0;
        registers[29] = 0;
        registers[30] = 0;
        registers[31] = 0;
    end
     assign s1 = registers[17];
     assign s2 = registers[18];
     assign s3 = registers[19];
     assign s4 = registers[20];
  //  always @ (posedge Clk) registers = Write
    always @ (negedge Clk) begin
        if (RegWrite) 
                begin
                if (WriteRegister != 0) begin
                        registers[WriteRegister] = WriteData;
                end
        end
        if (Clk) begin
            registers[0] = 0;
        end
    end
    //always @ (*) begin
       //assign ReadData1 = registers[ReadRegister1];
       //assign ReadData2 = registers[ReadRegister2];
        assign ReadData1 = registers[ReadRegister1];
        assign ReadData2 = registers[ReadRegister2]; 
    //end
    
//    always @ (posedge Clk) begin
//    if (RegWrite) 
//            begin
//            if (WriteRegister != 0) begin
//                    registers[WriteRegister] = WriteData;
//            end
//            end
//     end
endmodule
