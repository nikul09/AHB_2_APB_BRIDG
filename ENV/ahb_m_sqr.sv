
`ifndef ahb_m_sqr
`define ahb_m_sqr

class ahb_m_sqr extends uvm_sequencer #(ahb_trans);

    `uvm_component_utils(ahb_m_sqr)

    function new(string name = "ahb_m_sqr",uvm_component parent);
        super.new(name,parent);
    endfunction

endclass

`endif
