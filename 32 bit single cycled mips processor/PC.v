module program_counter #(parameter pc_width=32)(
    input clk,rst_n,
    input [pc_width-1:0]pc_next,
    output reg[pc_width-1:0]pc_reg
);
always @(posedge clk , negedge rst_n ) begin
    if(!rst_n)
    pc_reg<=0;
    else
    pc_reg<=pc_next;
end
endmodule

