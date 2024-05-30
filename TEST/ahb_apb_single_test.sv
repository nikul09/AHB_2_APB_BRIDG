
`ifndef ahb_apb_single_test
`define ahb_apb_single_test

class ahb_apb_single_test extends ahb_base_test;

    ahb_apb_single_sqn sngl_sqn;

    `uvm_component_utils(ahb_apb_single_test)

    function new(string name = "ahb_apb_single_test",uvm_component parent);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction

    task run_phase(uvm_phase phase);

        sngl_sqn = ahb_apb_single_sqn::type_id::create("sngl_sqn");
        phase.raise_objection(this);
        
        sngl_sqn.start(env.m_age.m_sqr);

        phase.phase_done.set_drain_time(this,200);
        phase.drop_objection(this);

    endtask

endclass

`endif

