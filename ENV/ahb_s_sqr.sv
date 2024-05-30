
`ifndef ahb_s_sqr
`define ahb_s_sqr

class ahb_s_sqr extends uvm_sequencer #(ahb_trans);

    `uvm_component_utils(ahb_s_sqr)

    function new(string name = "ahb_s_sqr",uvm_component parent);
        super.new(name,parent);
    endfunction

endclass

`endif
