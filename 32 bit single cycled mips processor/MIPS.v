
module mips(
     input  clk,rst_n
     
);


     wire [1:0]alu_op;
     wire RegDst;
     wire Reg_write;
     wire Alu_Src;
     wire direction;
     wire [2:0]opcode;
     wire mem_write;
     wire mem_read;
     wire MEMTOREG;
     wire jump;
     wire branch;
     wire [5:0]instruction_op;
     wire [5:0]instruction_fn;


data_path datapath(
.clk(clk),
.rst_n(rst_n),
.RegDst(RegDst),
.Reg_write(Reg_write),
.Alu_Src(Alu_Src),
.direction(direction),
.opcode(opcode),
.mem_write(mem_write),
.mem_read(mem_read),
.MEMTOREG(MEMTOREG),
.jump(jump),
.branch(branch),
.instruction_op(instruction_op),
.instruction_fn(instruction_fn)
);

alu_control_unit ALU_CONTROL(
.alu_op(alu_op),
.funct(instruction_fn),
.op_code_Sel(opcode),
.direction(direction)
);

main_control_unit MAIN_CONTROL(
.instr_opcode(instruction_op),
.Reg_dst(RegDst),
.alu_src(Alu_Src),
.mem_to_reg(MEMTOREG),
.Reg_write(Reg_write),
.mem_read(mem_read),
.mem_write(mem_write),
.branch(branch),
.alu_op(alu_op),
.jump(jump)
);


endmodule
`timescale 1ns / 1ps
module mips_tb;
reg clk;
reg rst_n;

mips dut(
.clk(clk),
.rst_n(rst_n)
);

localparam T=10;
always
begin
   clk=1;
   #(T/2);
   clk=0;  
   #(T/2);
end
initial
begin
    rst_n=0;
    #5;
    rst_n=1; 
end 

endmodule