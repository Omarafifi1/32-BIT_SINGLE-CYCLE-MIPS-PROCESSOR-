module adder #(parameter data_width=32)(
    input [data_width-1:0]ina,inb,
    output wire [data_width-1:0]out 
);
assign out = ina + inb;
endmodule

