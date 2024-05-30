
`ifndef ahb_apb_incr_test
`define ahb_apb_incr_test

class ahb_apb_incr_test extends ahb_base_test;

    ahb_apb_incr4_sqn incr_sq4;
    ahb_apb_incr8_sqn incr_sq8;
    ahb_apb_incr16_sqn incr_sq16;

    `uvm_component_utils(ahb_apb_incr_test)

    function new(string name = "ahb_apb_incr_test",uvm_component parent);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction

    task run_phase(uvm_phase phase);

        incr_sq4 = ahb_apb_incr4_sqn::type_id::create("incr_sq4");
        incr_sq8 = ahb_apb_incr8_sqn::type_id::create("incr_sq8");
        incr_sq16 = ahb_apb_incr16_sqn::type_id::create("incr_sq16");
        
        phase.raise_objection(this);
        
        incr_sq4.start(env.m_age.m_sqr);
        incr_sq8.start(env.m_age.m_sqr);
        incr_sq16.start(env.m_age.m_sqr);

        phase.phase_done.set_drain_time(this,200);
        phase.drop_objection(this);

    endtask

endclass

`endif

