module alu_control_unit(
    input [1:0]alu_op,
    input [5:0]funct,
    output reg[2:0]op_code_Sel,
    output reg direction
);
always@(*)begin
            op_code_Sel=0;
            direction=0;  
    case (alu_op)
        2'b00:   //add in case of lw and sw and addi
          op_code_Sel=3'b000;
        2'b01:    //sub in case of beq
          op_code_Sel=3'b001;
        2'b10:begin    //R_format_instructions
            case (funct)
                6'd32:  //add
                  op_code_Sel=3'b000;         
                6'd34:   //sub
                  op_code_Sel=3'b001;         
                6'd33:  //mul
                  op_code_Sel=3'b010;         
                6'd36:  //and
                  op_code_Sel=3'b011;         
                6'd37:  //or
                  op_code_Sel=3'b100;         
                6'd39:  //nor
                  op_code_Sel=3'b101;         
                6'd0 :begin  //sll               
                  op_code_Sel=3'b110; 
                  direction=1;
                end        
                6'd2 :begin   //srl             
                  op_code_Sel=3'b110; 
                  direction=0; 
                end       
                6'd3 :   //sra
                  op_code_Sel=3'b111;         
                default:begin
                    op_code_Sel=0;
                    direction=0;
                end 
            endcase
        end 
        default:begin
            op_code_Sel=0;
            direction=0;    
        end 
    endcase
end
endmodule

