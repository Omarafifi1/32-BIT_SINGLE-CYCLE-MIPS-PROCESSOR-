module sl2 #(parameter in_width=32,out_width=32)(
    input [in_width-1:0]in,
    output [out_width-1:0]out
);
assign out=in<<2;
endmodule

