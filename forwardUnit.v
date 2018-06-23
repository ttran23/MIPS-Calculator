    module forwardUnit(IDEXRs, IDEXRt, IDEXRd, EXMEMRd, MEMWBRt, MEMWBRd,EXALUSrc1Mux,
                memwrite, WBmemwrite, regwrite, WBregwrite, ALUMuxRs, ALUMuxRt);

input [4:0] IDEXRs, IDEXRt, IDEXRd, EXMEMRd, MEMWBRt, MEMWBRd;

input [1:0] memwrite, WBmemwrite;

input regwrite, WBregwrite, EXALUSrc1Mux;

output reg [1:0] ALUMuxRs;
output reg [1:0] ALUMuxRt; 
////////////////////////////////////////////////////////////////////////////////////////////////
// Basically, what's happening is what data I forward depends on whether memread is high or not,
// or if it was just high the cycle before. Basically, if we just had a lw two cycles ago, we want
// to forward different data than if the dependency was not a lw. The way I currently handle it is
// I look at memwrite(memread) and WBMemwrite(which carries the memread value from the cyle before).
// What *might* be happening is that we need to forward data because of the previous add instruction,
// but the instr before that was a lw that had nothing to do with either of those instrs or the regs used.
// The memread being high because of that past lw might be screwing with the forwarding as a result.
// Though now thinking it out, that shouldn't be the case as we want to forward using the first if
// statement, set ALUMuxRt to 1. That doesn't check WBMemwrite (which is high because of the aforemetioned
// lw, but memwrite, which should be low because it's an add instr, not a lw.
////////////////////////////////////////////////////////////////////////////////////////////////
    
always @(*) begin
    ALUMuxRs = 0;
    ALUMuxRt = 0;
    if(regwrite) begin
    
        //if next instruction is hazard (gap = 0)
        if(EXMEMRd != 0 && EXMEMRd == IDEXRs) ALUMuxRs = 1; //forward Mem's Rd to Ex's Rs
        if(EXMEMRd != 0 && EXMEMRd == IDEXRt) ALUMuxRt = 1; //forward Mem's Rd to Ex's Rt
        
     end
     
     if(WBregwrite) begin
        
        //if the one after the next instr is hazard (gap = 1)
        if(MEMWBRd == IDEXRs && EXMEMRd != IDEXRs && ALUMuxRs != 1) ALUMuxRs = 2; //forward Wb's Rd to Ex's Rs
        if(MEMWBRd == IDEXRt && EXMEMRd != IDEXRt && ALUMuxRt != 1) ALUMuxRt = 2; //forward Wb's Rd to Ex's Rt

        //if gap of two ---- might not be necessary ---- not needed since we write first and read second
       // if(MEMWBRd == IFIDRs); //forward WB's Rd to D's Rs
       // if(MEMWBRd == IFIDRt); //forward WB's Rd to D's Rt
        
    end
    
    if(WBmemwrite != 0) begin
    
        //lw and then needed next instr --- NEEDS A STALL
        if(MEMWBRt == IDEXRs) ALUMuxRs = 3; //forward Wb's Rt to Ex's Rs
        if(MEMWBRt == IDEXRt) ALUMuxRt = 3; //forward Wb's Rt to Ex's Rt
        
        //lw gap of one -- same as above but w/o stall
        if(MEMWBRt == IDEXRs) ALUMuxRs = 3; //forward Wb's Rt to Ex's Rs
        if(MEMWBRt == IDEXRt) ALUMuxRt = 3; //forward Wb's Rt to Ex's Rt
        
        //lw gap of two -- might not be necessary ---- not needed since we write first and read second
      //  if(MEMWBRt == IFIDRs); //forward Wb's Rt to D's Rs
      //  if(MEMWBRt == IFIDRt); //forward Wb's Rt to D's Rt
        
    end
   
end
endmodule