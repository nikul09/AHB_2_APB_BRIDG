

`ifndef ahb_mem
`define ahb_mem

class ahb_mem extends uvm_component;

    uvm_analysis_imp#(ahb_trans.sv,axi_mem) mem_ip;
    
    `uvm_component_utils(ahb_mem)

endclass
