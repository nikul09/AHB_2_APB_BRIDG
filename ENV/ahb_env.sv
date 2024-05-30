
`ifndef ahb_env
`define ahb_env

class ahb_env extends uvm_env;

    ahb_m_age m_age;
    ahb_s_age s_age;
    ahb_apb_sb sb;

    `uvm_component_utils(ahb_env)

    function new(string name =  "ahb_env",uvm_component parent);
        super.new(name,parent);
        `uvm_info(get_type_name(), "constructor!", UVM_LOW)
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_type_name(), "Build_phase", UVM_LOW)
        m_age = ahb_m_age::type_id::create("m_age",this);
        s_age = ahb_s_age::type_id::create("s_age",this);
        sb = ahb_apb_sb::type_id::create("sb",this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info(get_type_name(), "connect_phase", UVM_LOW)
        m_age.m_mon.ahb_mon_ap.connect(sb.ahb_ip);
        m_age.m_mon.apb_mon_ap.connect(sb.apb_ip);
    endfunction

endclass

`endif
