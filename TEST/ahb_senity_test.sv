
`ifndef ahb_senity_test
`define ahb_senity_test

class ahb_senity_test extends ahb_base_test;

    ahb_wr_rd_sqn wr_rd_sqn;

    `uvm_component_utils(ahb_senity_test)

    function new(string name = "ahb_senity_test",uvm_component parent);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction

    task run_phase(uvm_phase phase);
        cnf.NUM_OF_WR_TRANS_REQ = 2;
        cnf.NUM_OF_RD_TRANS_REQ = 2;

        wr_rd_sqn = ahb_wr_rd_sqn::type_id::create("wr_rd");
        phase.raise_objection(this);
        
        wr_rd_sqn.start(env.m_age.m_sqr);

        phase.phase_done.set_drain_time(this,200);
        phase.drop_objection(this);

    endtask

endclass

`endif

