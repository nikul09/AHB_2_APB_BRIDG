
`ifndef ahb_apb_wrap_test
`define ahb_apb_wrap_test

class ahb_apb_wrap_test extends ahb_base_test;

    ahb_apb_wrap4_sqn wrap_sq4;
    ahb_apb_wrap8_sqn wrap_sq8;
    ahb_apb_wrap16_sqn wrap_sq16;

    `uvm_component_utils(ahb_apb_wrap_test)

    function new(string name = "ahb_apb_wrap_test",uvm_component parent);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction

    task run_phase(uvm_phase phase);

        wrap_sq4 = ahb_apb_wrap4_sqn::type_id::create("wrap_sq4");
        wrap_sq8 = ahb_apb_wrap8_sqn::type_id::create("wrap_sq8");
        wrap_sq16 = ahb_apb_wrap16_sqn::type_id::create("wrap_sq16");
        
        phase.raise_objection(this);
        
        wrap_sq4.start(env.m_age.m_sqr);
        wrap_sq8.start(env.m_age.m_sqr);
        wrap_sq16.start(env.m_age.m_sqr);

        phase.phase_done.set_drain_time(this,200);
        phase.drop_objection(this);

    endtask

endclass

`endif

