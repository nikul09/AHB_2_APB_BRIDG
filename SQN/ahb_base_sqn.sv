
`ifndef ahb_base_sqn
`define ahb_base_sqn

class ahb_base_sqn extends uvm_sequence#(ahb_trans);

    int resp_cnt;
    ahb_config cnf;

    `uvm_object_utils(ahb_base_sqn)

    function new(string name = "ahb_base_sqn");
        super.new(name);
        cnf = ahb_config::type_id::create("cnf");
        `uvm_info(get_type_name(),"inside constructor",UVM_LOW)
    endfunction

    virtual task body();
        use_response_handler(1);
    endtask

    function void response_handler(uvm_sequence_item response);
        resp_cnt++;
    endfunction
endclass

`endif



