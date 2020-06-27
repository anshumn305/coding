`timescale 1ns/10ps
module fifo_tb;
logic empty  ;
logic full;
logic [4:0] data_in;
logic  write_clk;
logic  read_clk;
logic  write_clk_en;
logic  read_clk_en;
logic  read_clk_mod;
logic [4:0] data_out;
logic ref_clk;
logic write_clk_mod;
logic [5:0] write_clk_init;
int i;
logic [4:0] q;
logic fifo_data_out[4:0];
logic [4:0] sel  ;

mux mux_uut(.sel(sel),.data_out(data_out),.q(q));

initial begin
//data_in=5'b00000;
data_out=5'b00000;
sel=5'b00000;
write_clk_init = 6'b110111;
write_clk_mod=0;
full=1'b0;
empty=1'b0;
end

initial begin
repeat (3) begin
@(posedge write_clk)begin
if(write_clk_init[0]==1 || write_clk_init[0]==0)
write_clk_mod=write_clk_init[0];
end
@(posedge write_clk)begin
if(write_clk_init[1]==1 || write_clk_init[1]==0)
write_clk_mod=write_clk_init[1];
end
@(posedge write_clk)begin
if(write_clk_init[2]==1 || write_clk_init[2]==0)
write_clk_mod=write_clk_init[2];
end
@(posedge write_clk)begin
if(write_clk_init[3]==1 || write_clk_init[3]==0)
write_clk_mod=write_clk_init[3];
end
@(posedge write_clk)begin
if(write_clk_init[4]==1 || write_clk_init[4]==0)
write_clk_mod=write_clk_init[4];
end
@(posedge write_clk)begin
if(write_clk_init[5]==1 || write_clk_init[5]==0)
write_clk_mod=write_clk_init[5];
end
end
end

always @* begin //write_pointer
 write_clk_en  = write_clk & write_clk_mod;
end


 initial
 begin
$fsdbDumpvars("+fsdbfile+fifo.fsdb","+all");
   #500 $finish;

end
always//ref clk 100M
  begin
           ref_clk = 0;
    #10 ref_clk = 1;
    #40 ref_clk = 0;
    #60 ref_clk = 1;
  end
always//write_clk 500M
  begin
        write_clk  =0;
    #10 write_clk = 1;
    #10 write_clk = 0;
  end
always//read_clk 400M
  begin
        read_clk = 0;
    #10 read_clk = 1;
    #15 read_clk = 0;
  end

initial begin
read_clk_mod = 0;
#35 read_clk_mod = 1;
 end

always_comb begin //read_pointer
    read_clk_en  = read_clk & read_clk_mod;
end



initial begin 
data_in[0] = 1'b1;
data_in[1] = 1'b1;
data_in[2] = 1'b1;
data_in[3] = 1'b1;
data_in[4] = 1'b1;
end

initial begin
@(posedge write_clk_en)
if(!full)
begin
data_out[0]<=data_in[0];
end

@(posedge write_clk_en)
if(!full)
begin
data_out[1]<=data_in[1];
end

@(posedge write_clk_en)
if(!full)
begin
data_out[2]<=data_in[2];
end

@(posedge write_clk_en)
if(!full)
begin
data_out[3]<=data_in[3];
end

@(posedge write_clk_en)
if(!full)
begin
data_out[4]<=data_in[4];
end

@(posedge write_clk_en)
if(!full)
begin
full<=1'b1;
end
end


initial begin 

@(posedge read_clk_en)begin
if(!empty)
sel[0]<=1;
end

@(posedge read_clk_en)begin
if(!empty)
sel[1]<=1;
end

@(posedge read_clk_en)begin
if(!empty)
sel[2]<=1;
end

@(posedge read_clk_en)begin
if(!empty)
sel[3]<=1;
end

@(posedge read_clk_en)begin
if(!empty)
sel[4]<=1;
end

@(posedge read_clk_en)begin
if(!empty)
empty<=1;
end


end

endmodule
