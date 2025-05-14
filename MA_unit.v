module MA_unit(
    input clk, reset,
    input[31:0] op2, aluResult,
    input isLd, isSt,
    output reg[31:0] ldResult
);
    reg[7:0] data_memory [0:4095];

    wire[11:0] addr = aluResult[13:2];

    always@(*)
        begin
            if(isLd)
                ldResult = {data_memory[addr+3], data_memory[addr+2], data_memory[addr+1], data_memory[addr]};
            else
                ldResult = 32'b0;
        end

    integer i;
    always@(negedge clk)
        begin
            if(reset)
                begin
                    for(i=0; i<4096; i=i+1)
                        data_memory[i] <= 8'b0;
                end
            else
                begin
                    if(isSt)
                        begin
                            data_memory[addr] <= op2[7:0];
                            data_memory[addr+1] <= op2[15:8];
                            data_memory[addr+2] <= op2[23:16];
                            data_memory[addr+3] <= op2[31:24];
                        end
                    else
                        begin
                            data_memory[addr] <= data_memory[addr];
                            data_memory[addr+1] <= data_memory[addr+1];
                            data_memory[addr+2] <= data_memory[addr+2];
                            data_memory[addr+3] <= data_memory[addr+3];
                        end
                end
        end
endmodule