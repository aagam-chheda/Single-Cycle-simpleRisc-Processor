module IF_unit(
    input reset,
    input isBranchTaken,
    input[31:0] branchPC,
    input[0:8191] instructionMemory,
    output reg[31:0] PC,
    output[31:0] inst
);
    always@(*)
        if (reset) PC=0;
        else
            begin
                if(isBranchTaken) PC=branchPC;
                else PC=PC+4;
            end
    
    instruction_memory instruction_memory(
        .PC(PC),
        .instructionMemory_data(instructionMemory),
        .instruction(inst)
    );

endmodule