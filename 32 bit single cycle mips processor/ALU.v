module ALU #(parameter data_width=32)(
    input [data_width-1:0]in1,
    input [data_width-1:0]in2,
    input [2:0]opcode,
    input [4:0]shamt,
    input direction,
    output zero_flag,
    output in1_slt_flag,in2_slt_flag,
    output reg[data_width-1:0]ALU_result  
);
assign zero_flag=(in1==in2)?1'b1:1'b0;
assign in1_slt_flag=(in1<in2)?1'b1:1'b0;
assign in2_slt_flag=(in2<in1)?1'b1:1'b0;
always @(*) begin
    ALU_result=0;
    case (opcode)
        3'b000:
        ALU_result=(in1) + (in2); 
        3'b001:
        ALU_result=(in1) - (in2);
        3'b010:
        ALU_result=(in1) * (in2);
        3'b011:
        ALU_result=(in1) & (in2);
        3'b100:
        ALU_result=(in1) | (in2);
        3'b101:
        ALU_result=(in1) |~ (in2);
        3'b110:begin
        if(direction)
        ALU_result=(in2) << (shamt);
        else
        ALU_result=(in2) >> (shamt);
        end
        3'b111: 
        ALU_result=(in2) >>> (shamt);  //shift_right_arithmetic
        default: ALU_result=0;
    endcase
end
endmodule

