`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - SignExtension.v
// Description - Sign extension module.
////////////////////////////////////////////////////////////////////////////////
module SignExtension(in, out);

    /* A 16-Bit input word */
    input [15:0] in;
    
    /* A 32-Bit output word */
    output [31:0] out;
    
    /* Fill in the implementation here ... */
//    always @ (in)
//    begin
//        out[31:0] <= { {16{in[15]}}, in[15:0] };
//    end
    
    //appends 16 bits from 31 with the value in in[15], then appends the rest of in
    assign out = { {16{in[15]}}, in[15:0] };

endmodule
