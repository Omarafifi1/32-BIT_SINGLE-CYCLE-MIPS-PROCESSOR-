module data_path (
    input  clk,rst_n,
    input  RegDst,
    input  Reg_write,
    input  Alu_Src,
    input  direction,
    input  [2:0]opcode,
    input  mem_write,
    input  mem_read,
    input  MEMTOREG,
    input  jump,
    input  branch,
    output  [5:0]instruction_op,
    output  [5:0]instruction_fn
);
   parameter mux0_width=5 , in_width0=26 , out_width0=28 ,width=32;

wire [width-1:0]pc_next;
wire [width-1:0]pc_reg;
wire [width-1:0]instruction;/////////////
wire [mux0_width-1:0]out_M0;
wire [width-1:0]out_M1,out_M2,out_M3,out_M4;
wire [width-1:0]read_data1,read_data2;
wire [width-1:0]s_extend_out;
wire zero_flag;
wire [width-1:0]ALU_result;
wire [width-1:0]read_data;
wire [width-1:0]out_A0;
wire [width-1:0]out_A1;
wire [out_width0-1:0]out_sl2_jump;
wire [width-1:0]out_sl2_branch;

assign instruction_op=instruction[31:26];
assign instruction_fn=instruction[5:0];



program_counter PC(
.clk(clk),
.rst_n(rst_n),
.pc_next(pc_next),
.pc_reg(pc_reg)
);

instruction_memory IM(
.read_address(pc_reg),
.instruction(instruction)
);

mux #(.width(mux0_width))MUX_REGDST(
.in1(instruction[20:16]),
.in2(instruction[15:11]),
.sel(RegDst),
.out(out_M0)
);

register_file RF(
.clk(clk),
.rst_n(rst_n),
.read_register1(instruction[25:21]),
.read_register2(instruction[20:16]),
.write_register(out_M0),
.write_data(out_M2),
.Reg_write(Reg_write),
.read_data1(read_data1),
.read_data2(read_data2)
);


mux MUX_ALUSRC(
.in1(read_data2),
.in2(s_extend_out),
.sel(Alu_Src),
.out(out_M1)
);

ALU ALU0(
.in1(read_data1),
.in2(out_M1),
.shamt(instruction[10:6]),
.direction(direction),
.opcode(opcode),
.zero_flag(zero_flag),
.in1_slt_flag(),
.in2_slt_flag(),
.ALU_result(ALU_result)
);

data_memory DM(
.clk(clk),
.rst_n(rst_n),
.mem_write(mem_write),
.mem_read(mem_read),
.address(ALU_result),
.write_data(read_data2),
.read_data(read_data)
);

mux MUX_MEMTOREG(
.in1(ALU_result),
.in2(read_data),
.sel(MEMTOREG),
.out(out_M2)
);


sign_extension S_EXTEND(
.in(instruction[15:0]),
.out(s_extend_out)
);




adder ADD_PC_PLUS_4(
.ina(pc_reg),
.inb('d4),
.out(out_A0) 
);

sl2 #(.in_width(in_width0),.out_width(out_width0)) SHIFT_4_JUMP (
.in(instruction[25:0]),
.out(out_sl2_jump)
);

adder ADD_4_BRANCH(
.ina(out_A0),
.inb(out_sl2_branch),
.out(out_A1) 
);

sl2 SHIFT_4_BRANCH(
.in(s_extend_out),
.out(out_sl2_branch)
);

mux MUX_BRANCH(
.in1(out_A0),
.in2(out_A1),
.sel(branch & zero_flag),
.out(out_M4)
);

mux MUX_JUMP(
.in1(out_M4),
.in2({out_A0[31:28],out_sl2_jump}),
.sel(jump),
.out(pc_next)
);

endmodule
 


