module EX_unit(
    input[31:0] branchTarget, op1,
    input isRet,
    output[31:0] branchPC,
    input isBeq, isUBranch, isBgt,
    output isBranchTaken,
    input[31:0] immx,
    input[31:0] op2,
    input isImmediate,
    input isAdd, isSub, isCmp, isMul, isDiv, isMod, isLsl, isLsr, isAsr, isOr, isNot, isAnd, isMov,
    output[31:0] aluResult
);
    assign branchPC = (isRet) ? op1 : branchTarget;

    wire[31:0] A,B;
    assign A = op1;
    assign B = (isImmediate) ? immx : op2;
    assign aluResult = (isAdd) ? A+B :
                       (isSub) ? A-B :
                       (isMul) ? A*B :
                       (isDiv) ? A/B :
                       (isMod) ? A%B :
                       (isLsl) ? A<<B :
                       (isLsr) ? A>>B :
                       (isAsr) ? A>>>B :
                       (isOr)  ? A|B :
                       (isNot) ? ~B :
                       (isAnd) ? A&B :
                       (isMov) ? B : 32'b0;
    wire E, GT;
    assign E = (isCmp) ? (A==B) : 1'b0;
    assign GT = (isCmp) ? (A>B) : 1'b0;

    assign isBranchTaken = (isBeq && E) || (isUBranch) || (isBgt && GT);

endmodule