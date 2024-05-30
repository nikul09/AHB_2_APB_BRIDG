

`ifndef ahb_base_test
`define ahb_base_test

class ahb_base_test extends uvm_test;

    ahb_env env;
    ahb_config cnf;

    `uvm_component_utils(ahb_base_test)

    function new(string name = "ahb_base_test",uvm_component parent);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env = ahb_env::type_id::create("env",this);
        cnf = ahb_config::type_id::create("cnf",this);
    endfunction
    
    function void end_of_elaboration_phase(uvm_phase phase);
        super.end_of_elaboration_phase(phase);
        uvm_top.print_topology();
    endfunction

endclass

`endif
