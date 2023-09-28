module data_memory #(parameter data_width=32, addr_width=32 ,data_depth=32)(
    input clk ,rst_n,
    input mem_write,mem_read,
    input [addr_width-1:0]address,
    input [data_width-1:0]write_data,
    output reg[data_width-1:0]read_data
);  
    integer i;
    reg [data_width-1:0]data_mem[0:data_depth-1];
always@(posedge clk,negedge rst_n)
begin
    if(!rst_n)begin
        for(i=0 ; i != data_depth ; i=i+1) 
        data_mem[i]<=0;
    end
    else if(mem_write)
    data_mem[address]<=write_data;
    else if(mem_read)
    read_data<=data_mem[address];
    else
    data_mem[address]<=data_mem[address];
end
endmodule

