module register_file #(parameter data_width=32, addr_width=5)(
    input clk,rst_n,
    input [addr_width-1:0]read_register1,
    input [addr_width-1:0]read_register2,
    input [addr_width-1:0]write_register,
    input [data_width-1:0]write_data,
    input Reg_write,
    output wire [data_width-1:0]read_data1,
    output wire [data_width-1:0]read_data2
);
reg [data_width-1:0]RF[0:(2**addr_width)-1];

assign read_data1=RF[read_register1];
assign read_data2=RF[read_register2];
integer i;
always @(posedge clk,negedge rst_n ) begin
    if(!rst_n)begin
       for(i=0 ; i != (2**addr_width-1) ; i=i+1) 
        RF[i]<=0;
    end
           
    else if (Reg_write)    
        RF[write_register]<=write_data;
    else
       RF[write_register]<=RF[write_register]; 
end
endmodule 

