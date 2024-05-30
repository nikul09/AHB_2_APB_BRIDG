
`ifndef ahb_m_age
`define ahb_m_age

class ahb_m_age extends uvm_agent;
    
    ahb_m_drv m_drv;
    ahb_m_sqr m_sqr;
    ahb_m_mon m_mon;

    `uvm_component_utils(ahb_m_age)

    function new(string name =  "ahb_m_age",uvm_component parent);
        super.new(name,parent);
        `uvm_info(get_type_name(),"constructor",UVM_LOW)
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_type_name(),"build phase",UVM_LOW)
        m_drv = ahb_m_drv::type_id::create("m_drv",this);
        m_sqr = ahb_m_sqr::type_id::create("m_sqr",this);
        m_mon = ahb_m_mon::type_id::create("m_mon",this);
    endfunction
    
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info(get_type_name(),"connect phase",UVM_LOW)
        m_drv.seq_item_port.connect(m_sqr.seq_item_export);
        //m_mon.m_mon_ap.connect
    endfunction 
endclass

`endif
