module mux #(parameter width=32)(
    input [width-1:0]in1,
    input [width-1:0]in2,
    input sel,
    output reg[width-1:0]out
);
always @(*) begin
    case (sel)
        1'b0:out=in1; 
        1'b1:out=in2;
        default:out=1'bx; 
    endcase
end
endmodule
