`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/17/2016 09:32:25 AM
// Design Name: 
// Module Name: TopModule_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module TopModule_tb();

    reg Rst;
    reg Clk;
    wire [31:0] out;
    wire [31:0] programcounter;
    //wire [6:0] out7;
    //wire [7:0] en_out;
    
    // module TopModule(Rst, Clk, out, ProgramCounter);
    //TopModule tippytop(.Clk(Clk), .out(out), .ProgramCounter(programcounter));    //without reset
    TopModule tippytop(.Rst(Rst), .Clk(Clk), .out(out), .ProgramCounter(programcounter));   //with reset
    
    //TopModule tb(.Rst(Rst), .Clk(Clk), .out7(out7), .en_out(en_out));
    
    always begin
        Clk <= 1'b0;
        forever #10 Clk <= ~Clk;
    end
    
    initial begin
        Rst <= 1;
        #100 Rst <= 0;
        //#10 Rst <= 1;
        //#1000 Rst <= 0;
    end
    
    
endmodule
