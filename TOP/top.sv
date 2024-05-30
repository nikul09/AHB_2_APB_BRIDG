/*
  Test bench are working on 500MHZ Frequency
*/

`include "uvm_macros.svh"
`include "../BRI/top_rtl.v"
`include "../MEM/ahb_mem.sv"

module ahb_top;

import uvm_pkg::*;
import ahb_pkg::*;

bit HCLK;
bit HRESETn;

/*
  called interface here
*/

ahb_inf ahb_pinf(HCLK,HRESETn);
apb_inf apb_pinf(HCLK,HRESETn);

/*
  set interface in uvm_configuartion Data base 
*/

initial begin
    uvm_config_db#(virtual ahb_inf)::set(null,"*","ahb_vinf",ahb_pinf);
    uvm_config_db#(virtual apb_inf)::set(null,"*","apb_vinf",apb_pinf);
end

/*
  Generate clock with 500MHZ clock Frequence  
*/

initial begin
    forever #5 HCLK = !HCLK;
end

/*
  Reset signal is Active Low, Reset Tesbench for delay of #5
*/

initial begin
    HRESETn = 0;
    #10;
    HRESETn = 1;
end

/*
  Run test
*/

initial begin
    run_test("");
end

top ahb_apb_bridge_RTL(
    .HCLK(HCLK),
    .HRESETn(HRESETn),

    .HADDR(ahb_pinf.HADDR),
    .HWDATA(ahb_pinf.HWDATA),
    .HTRANS(ahb_pinf.HTRANS),
    .HWRITE(ahb_pinf.HWRITE),
    .HRESP(ahb_pinf.HRESP),
    .HRDATA(ahb_pinf.HRDATA),
    .HSIZE(ahb_pinf.HSIZE),
    .HREADYin(ahb_pinf.HREADYin),
    .HREADYout(ahb_pinf.HREADYout),
    
    .PADDR(apb_pinf.PADDR),
    .PWDATA(apb_pinf.PWDATA),
    .PSEL(apb_pinf.PSEL),
    .PWRITE(apb_pinf.PWRITE),
    .PENABLE(apb_pinf.PENABLE),
    .PRDATA(apb_pinf.PRDATA),
    .PSLVERR(apb_pinf.PSLVERR)
);

apb_mem_rtl mem_t(
    .clk(HCLK),
    .rst(HRESETn),
    .din(apb_pinf.PWDATA),
    .addr(apb_pinf.PADDR),
    .valid(apb_pinf.PENABLE),
    .wr_rd(apb_pinf.PWRITE),
    .dout(apb_pinf.PRDATA)
);

initial begin
    $dumpfile("waveform.vcd");
    $dumpvars(0,ahb_top);
end


endmodule


/* Git hub Bridge */

/*
Bridge_Top ahb_apb_bridge_RTL(
    .Hclk(HCLK),
    .Hresetn(HRESETn),

    .Haddr(ahb_pinf.HADDR),
    .Hwdata(ahb_pinf.HWDATA),
    .Htrans(ahb_pinf.HTRANS),
    .Hwrite(ahb_pinf.HWRITE),
    .Hresp(ahb_pinf.HRESP),
    .Hrdata(ahb_pinf.HRDATA),
    .Hreadyout(ahb_pinf.HREADYout),
    //.HSIZE(ahb_pinf.HSIZE),
    .Hreadyin(ahb_pinf.HREADYin),
    
    .Paddr(ahb_pinf.PADDR),
    .Pwdata(ahb_pinf.PWDATA),
    .Pselx(ahb_pinf.PSEL),
    .Pwrite(ahb_pinf.PWRITE),
    .Penable(ahb_pinf.PENABLE),
    .Prdata(ahb_pinf.PRDATA)
);

*/
