module OF_unit(
    input isSt, isRet,
    input [31:0] PC,
    input [31:0] inst,
    output reg[31:0] immx,
    output[31:0] branchTarget,
    output[31:0] op1,
    output[31:0] op2,
    output[5:0] opcode_and_I,

    input[31:0] aluResult, ldResult,
    input isWb, isLd, isCall,
    input clk, reset
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

    assign opcode_and_I = inst[31:26];


    wire[31:0] result;
    assign result = ({isCall,isLd}==2'b00) ? aluResult :
                    ({isCall,isLd}==2'b01) ? ldResult :
                    ({isCall,isLd}==2'b10) ? PC+4 : 32'b0;

    wire[3:0] reg_addr;
    assign reg_addr = (isCall) ? reg_file[15] : inst[25:22]; 

    always@(negedge clk)
        begin
            if(reset)
                begin
                    reg_file[0] <= 32'b0;
                    reg_file[1] <= 32'b0;
                    reg_file[2] <= 32'b0;
                    reg_file[3] <= 32'b0;
                    reg_file[4] <= 32'b0;
                    reg_file[5] <= 32'b0;
                    reg_file[6] <= 32'b0;
                    reg_file[7] <= 32'b0;
                    reg_file[8] <= 32'b0;
                    reg_file[9] <= 32'b0;
                    reg_file[10] <= 32'b0;
                    reg_file[11] <= 32'b0;
                    reg_file[12] <= 32'b0;
                    reg_file[13] <= 32'b0;
                    reg_file[14] <= 32'b0;
                    reg_file[15] <= PC+4; // PC+4
                end
            else
                begin
                    if(isWb)
                        reg_file[reg_addr] <= result;
                    else
                        reg_file[reg_addr] <= reg_file[reg_addr];
                end
        end
endmodule