module single_cycle_simpleRisc_processor(
    input clk, reset,
    input[0:8191] instructionMemory
);
    wire isBranchTaken;
    wire[31:0] branchPC;
    wire[31:0] PC;
    wire[31:0] inst;
    IF_unit IF_unit(
        .reset(reset),
        .isBranchTaken(isBranchTaken),
        .branchPC(branchPC),
        .instructionMemory(instructionMemory),
        .PC(PC),
        .inst(inst)
    );


    wire isSt, isRet;
    wire [31:0] immx;
    wire [31:0] branchTarget;
    wire [31:0] op1;
    wire [31:0] op2;
    wire [5:0] opcode_and_I;
    wire [31:0] aluResult, ldResult;
    wire isWb, isLd, isCall;
    OF_unit OF_unit(
        .isSt(isSt),
        .isRet(isRet),
        .PC(PC),
        .inst(inst),
        .immx(immx),
        .branchTarget(branchTarget),
        .op1(op1),
        .op2(op2),
        .opcode_and_I(opcode_and_I),
        .aluResult(aluResult),
        .ldResult(ldResult),
        .isWb(isWb),
        .isLd(isLd),
        .isCall(isCall),
        .clk(clk),
        .reset(reset)
    );


    wire isBeq, isUBranch, isBgt;
    wire isImmediate;
    wire isAdd, isSub, isCmp, isMul, isDiv, isMod, isLsl, isLsr, isAsr, isOr, isNot, isAnd, isMov;
    EX_unit EX_unit(
        .branchTarget(branchTarget),
        .op1(op1),
        .isRet(isRet),
        .branchPC(branchPC),
        .isBeq(isBeq),
        .isUBranch(isUBranch),
        .isBgt(isBgt),
        .isBranchTaken(isBranchTaken),
        .immx(immx),
        .op2(op2),
        .isImmediate(isImmediate),
        .isAdd(isAdd),
        .isSub(isSub),
        .isCmp(isCmp),
        .isMul(isMul),
        .isDiv(isDiv),
        .isMod(isMod),
        .isLsl(isLsl),
        .isLsr(isLsr),
        .isAsr(isAsr),
        .isOr(isOr),
        .isNot(isNot),
        .isAnd(isAnd),
        .isMov(isMov),
        .aluResult(aluResult)
    );


    MA_unit MA_unit(
        .clk(clk),
        .reset(reset),
        .op2(op2),
        .aluResult(aluResult),
        .isLd(isLd),
        .isSt(isSt),
        .ldResult(ldResult)
    );


    control_unit control_unit(
        opcode_and_I,
        isSt, isLd, isBeq, isBgt, isRet, isImmediate, isWb, isUBranch,
        isCall, isAdd, isSub, isCmp, isMul, isDiv, isMod, isLsl, isLsr, isAsr,
        isOr, isAnd, isNot, isMov
    );
endmodule