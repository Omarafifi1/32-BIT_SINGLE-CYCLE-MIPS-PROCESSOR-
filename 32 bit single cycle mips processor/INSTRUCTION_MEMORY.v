module instruction_memory #(parameter instr_width=32, addr_width=32)(
    input [addr_width-1:0]read_address,
    output  [instr_width-1:0]instruction
);
reg [instr_width-1:0]instruction_mem[0:8];

assign instruction = instruction_mem[read_address/4]; //if the memory is word aligned (the 32-bit instruction is stored in a single row )
//assign instruction=instruction_mem[read_address];   //if the memory is 1 byte  aligned (the 32-bit instruction is stored in 4 rows )
initial begin
	$readmemh("factorial_of_7.txt",instruction_mem);
	//$readmemb("IM.txt",instruction_mem);
end
				 
				 

endmodule



