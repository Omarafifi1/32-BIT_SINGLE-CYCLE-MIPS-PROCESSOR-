module sign_extension #(parameter in_width=16,out_width=32)(
    input [in_width-1:0]in,
    output reg[out_width-1:0]out
);
always @(*) begin
    if(in[15])
    out={{16{1'b0}},in};
   else
     out={{16{1'b0}},in};
end
endmodule

