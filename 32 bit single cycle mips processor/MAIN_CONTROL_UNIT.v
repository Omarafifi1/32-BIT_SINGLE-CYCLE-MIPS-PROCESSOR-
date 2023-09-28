module main_control_unit(
    input [5:0]instr_opcode,
    output Reg_dst,
    output alu_src,
    output mem_to_reg,
    output Reg_write,
    output mem_read,
    output mem_write,
    output branch,
    output [1:0]alu_op,
    output jump
   
    
    
);
reg [9:0]control_lines;
assign {Reg_dst,alu_src,mem_to_reg,Reg_write,mem_read,mem_write,branch,alu_op,jump}=control_lines;
always @(*) begin
    control_lines=10'd0;
    case (instr_opcode)
        6'd0:  //R_format_instructions
         control_lines=10'b1001000100;
        6'd43: //sw
         control_lines=10'bx1x0010000;
        6'd35: //lw 
         control_lines=10'b0111100000;
        6'd4: //beq  
         control_lines=10'bx0x0001010;
        6'd2: //jump
         control_lines=10'bxxx000xxx1; 
        6'd8: //addi
         control_lines=10'b0101000000; 
        default: control_lines=10'd0;
    endcase
end
endmodule

