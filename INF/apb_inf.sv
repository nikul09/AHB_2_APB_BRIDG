
`ifndef apb_inf
`define apb_inf

interface apb_inf(input bit HCLK,HRESETn);
 
    logic [31 : 0] PADDR;
    logic [31 : 0] PWDATA;
    logic [31 : 0] PRDATA;
    logic [2 : 0]  PSEL;
    logic          PWRITE;
    logic          PENABLE;
    logic          PSLVERR;
    

    clocking m_mon@(posedge HCLK);
        default input #1 output #1;
        
        input PADDR;
        input PWDATA;
        input PWRITE;
        input PENABLE;
    
    endclocking

endinterface

`endif
