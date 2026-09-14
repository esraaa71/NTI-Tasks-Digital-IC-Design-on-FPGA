module memory_test;

localparam AWIDTH=5;
localparam DWIDTH=8;

reg clk;
reg wr;
reg rd;
reg [AWIDTH-1:0] addr;
wire [DWIDTH-1:0] data;
reg [DWIDTH-1:0] rdata;
reg [AWIDTH-1:0] test_addr;
reg [DWIDTH-1:0] test_data;

assign data=rdata;

memory #(AWIDTH,DWIDTH) m1(clk,wr,rd,addr,data);

task expect;
input [DWIDTH-1:0] exp_data;
begin
if(data!==exp_data)
begin
$display("TEST FAILED");
$display("At time %0d addr=%b data=%b",$time,addr,data);
$display("data should be %b",exp_data);
$finish;
end
else
$display("At time %0d addr=%b data=%b",$time,addr,data);
end
endtask

task write_memory;
input [AWIDTH-1:0] address;
input [DWIDTH-1:0] value;
begin
$display("Writing addr=%b data=%b",address,value);
wr=1;
rd=0;
addr=address;
rdata=value;
@(negedge clk);
end
endtask

task read_memory;
input [AWIDTH-1:0] address;
input [DWIDTH-1:0] value;
begin
$display("Reading addr=%b data=%b",address,value);
wr=0;
rd=1;
addr=address;
rdata='bz;
@(negedge clk);
expect(value);
end
endtask

initial repeat(67)
begin
#5 clk=1;
#5 clk=0;
end

initial @(negedge clk)
begin
write_memory(0,-1);
write_memory(-1,0);

read_memory(0,-1);
read_memory(-1,0);

$display("Writing ascending data to descending addresses");
test_addr=-1;
test_data=0;
while(test_addr)
begin
write_memory(test_addr,test_data);
test_addr=test_addr-1;
test_data=test_data+1;
end

$display("Reading ascending data from descending addresses");
test_addr=-1;
test_data=0;
while(test_addr)
begin
read_memory(test_addr,test_data);
test_addr=test_addr-1;
test_data=test_data+1;
end

$display("TEST PASSED");
$finish;
end

endmodule
