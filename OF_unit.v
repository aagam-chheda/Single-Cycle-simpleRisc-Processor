module OF_unit(
    input isSt, isRet,
    input [31:0] PC,
    input [31:0] inst,
    output reg[31:0] immx,
    output[31:0] branchTarget,
    output[31:0] op1,
    output[31:0] op2
);
    wire[31:0] temp;
    assign temp={{3{inst[26]}},inst[26:0],2'b0};
    assign branchTarget=PC+temp;

    always@(*)
        begin
            case(inst[17:16])
                2'b01: immx={16'b0,inst[15:0]}; // u-modified immediate
                2'b10: immx={inst[15:0],16'b0}; // h-modified immediate
                default: immx={{16{inst[15]}},inst[15:0]};
            endcase
        end

    reg[31:0] reg_file [0:15];

    assign op1 = (isRet) ? reg_file[15] : reg_file[inst[21:18]];
    assign op2 = (isSt) ? reg_file[inst[25:22]] : reg_file[inst[17:14]];

endmodule