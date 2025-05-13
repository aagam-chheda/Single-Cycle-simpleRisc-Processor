module instruction_memory(
    input [31:0] PC,
    input[0:8191] instructionMemory_data,
    output reg [31:0] instruction
);
    reg [31:0] instructionMemory_array [0:255];

    integer i;
    always @(*)
        begin
            for (i = 0; i < 256; i = i + 1)
                instructionMemory_array[i] = instructionMemory_data[i*32 +: 32];

            instruction = instructionMemory_array[PC[9:2]];
        end
endmodule