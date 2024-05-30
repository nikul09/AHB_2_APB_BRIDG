
`ifndef ahb_s_age
`define ahb_s_age

class ahb_s_age extends uvm_monitor;

    ahb_s_drv s_drv;
    ahb_s_sqr s_sqr;
    //ahb_s_mon s_mon;

    `uvm_component_utils(ahb_s_age)

    function new(string name =  "ahb_s_age",uvm_component parent);
        super.new(name,parent);
        `uvm_info(get_type_name(), "constructor!", UVM_LOW)
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_type_name(), "Build_phase", UVM_LOW)
        s_drv = ahb_s_drv::type_id::create("s_drv",this);
        s_sqr = ahb_s_sqr::type_id::create("s_sqr",this);
       // s_mon = ahb_s_mon::type_id::create("s_mon",this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info(get_type_name(), "connect_phase", UVM_LOW)
        s_drv.seq_item_port.connect(s_sqr.seq_item_export);
        //s_mon.s_mon_ap.connect(s_drv.s_drv_ip);
    endfunction

endclass

`endif
