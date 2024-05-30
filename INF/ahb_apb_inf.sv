
`ifndef ahb_inf
`define ahb_inf

interface ahb_inf(input bit HCLK,HRESETn);
 
    logic [31 : 0] HADDR;
    logic [31 : 0] HWDATA;
    logic [1:0]    HTRANS;
    logic [31 : 0] HRDATA;
    logic [1:0]    HRESP;
    logic [2 : 0]  HSIZE;
    logic [2:0]    HBURST;
    logic          HWRITE;
    logic          HREADY = 1;
    logic          HREADYin = 1;
    logic          HREADYout;

    clocking m_drv@(posedge HCLK);
        default input #1 output #1;
       
        output HADDR;
        output HWDATA;
        output HTRANS;
        output HSIZE;
        output HBURST;
        output HWRITE;
        output HREADYin;
        input HREADYout;
        input HRESP;

    endclocking


    clocking m_mon@(posedge HCLK);
        default input #1 output #1;
        
        input HADDR;
        input HWDATA;
        input HTRANS;
        input HSIZE;
        input HBURST;
        input HWRITE;
        input HREADYout;

    endclocking

endinterface

`endif
