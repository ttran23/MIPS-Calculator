module Mux1Bit2To1(out, inA, inB, sel);

    output reg out;
    
    input inA;
    input inB;
    input sel;

    /* Fill in the implementation here ... */ 
    always @ (inA, inB, sel)
    begin
        if (sel == 0)
            out <= inA;
        else //if (sel == 1)
            out <= inB;
    end
endmodule