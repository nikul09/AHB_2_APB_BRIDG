
`ifndef ahb_apb_unb_incr_test
`define ahb_apb_unb_incr_test

class ahb_apb_unb_incr_test extends ahb_base_test;

    ahb_apb_unb_incr_sqn unb_incr_sq;

    `uvm_component_utils(ahb_apb_unb_incr_test)

    function new(string name = "ahb_apb_unb_incr_test",uvm_component parent);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction

    task run_phase(uvm_phase phase);

        cnf.NUM_INCR_TRANSFER = 5;

        unb_incr_sq = ahb_apb_unb_incr_sqn::type_id::create("unb_sq");
        phase.raise_objection(this);
        
        unb_incr_sq.start(env.m_age.m_sqr);

        phase.phase_done.set_drain_time(this,200);
        phase.drop_objection(this);

    endtask

endclass

`endif

