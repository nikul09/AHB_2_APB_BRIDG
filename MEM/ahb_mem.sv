
module apb_mem_rtl
  #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32
  )
  (
    input clk,
    input rst,
    input [DATA_WIDTH-1:0]din,
    input [ADDR_WIDTH-1:0]addr,
    input valid,
    input wr_rd,
    output reg [DATA_WIDTH-1:0]dout
  );

  //integer i;

  /* apb memory as a associative arry */

  reg [DATA_WIDTH-1:0]mem[reg[ADDR_WIDTH - 1:0]];
   
  always@(posedge clk)begin
      if(rst)begin 
          if(valid)begin
              if(wr_rd)begin 
                  mem[addr] = din;
              end
              else begin 
                  if(mem.exists(addr))begin
                      dout = mem[addr];
                  end
                  else dout = 32'hffffffff;
              end
          end
      end
      else begin
          for(int i = 0; i<$size(mem); i++)begin
              mem[i] = 0;
              dout = 0;
          end
      end
  end
endmodule
