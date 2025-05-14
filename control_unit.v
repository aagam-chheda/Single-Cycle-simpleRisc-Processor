module control_unit(
    input[5:0] opcode_and_I,
    output isSt, isLd, isBeq, isBgt, isRet, isImmediate, isWb, isUBranch,
    output isCall, isAdd, isSub, isCmp, isMul, isDiv, isMod, isLsl, isLsr, isAsr,
    output isOr, isAnd, isNot, isMov
);
    wire op1, op2, op3, op4, op5, I;
    assign op1 = opcode_and_I[0];
    assign op2 = opcode_and_I[1];
    assign op3 = opcode_and_I[2];
    assign op4 = opcode_and_I[3];
    assign op5 = opcode_and_I[4];
    assign I = opcode_and_I[5];

    assign isSt = !op5 & op4 & op3 & op2 & op1;
    assign isLd = !op5 & op4 & op3 & op2 & !op1;
    assign isBeq = op5 & !op4 & !op3 & !op2 & !op1;
    assign isBgt = op5 & !op4 & !op3 & !op2 & op1;
    assign isRet = op5 & !op4 & op3 & !op2 & !op1;
    assign isImmediate = I;

    assign isWb = !(op5 | !op5&op3&op1&(op4|!op2)) | (op5 & !op4 & !op3 & op2 & op1);
    assign isUBranch = op5&!op4&(!op3&op2 | op3&!op2&op1);
    assign isCall = op5 & !op4 & !op3 & op2 & op1;

    assign isAdd = (!op5 & !op4 & !op3 & !op2 & !op1)|(!op5 & op4 & op3 & op2);
    assign isSub = !op5 & !op4 & !op3 & !op2 & op1;
    assign isCmp = !op5 & !op4 & op3 & !op2 & op1;
    assign isMul = !op5 & !op4 & !op3 & op2 & !op1;
    assign isDiv = !op5 & !op4 & !op3 & op2 & op1;
    assign isMod = !op5 & !op4 & op3 & !op2 & !op1;
    assign isLsl = !op5 & op4 & !op3 & op2 & !op1;
    assign isLsr = !op5 & op4 & !op3 & op2 & op1;
    assign isAsr = !op5 & op4 & op3 & !op2 & !op1;
    assign isOr = !op5 & !op4 & op3 & op2 & op1;
    assign isAnd = !op5 & !op4 & op3 & op2 & !op1;
    assign isNot = !op5 & op4 & !op3 & !op2 & !op1;
    assign isMov = !op5 & op4 & !op3 & !op2 & op1;
endmodule