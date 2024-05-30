
`ifndef ahb_apb_unb_incr_sqn
`define ahb_apb_unb_incr_sqn

class ahb_apb_unb_incr_sqn extends ahb_base_sqn;

    `uvm_object_utils(ahb_apb_unb_incr_sqn)

    function new(string name = "ahb_apb_unb_incr_sqn");
        super.new(name);
        `uvm_info(get_type_name(),"inside constructor",UVM_LOW)
    endfunction

    task body();
        super.body();
        repeat(2)begin

            req = ahb_trans::type_id::create("req");
            
            start_item(req);
	  
            assert(req.randomize() with {
                req.wr_rd == WR_REQ;
                req.size == 2;
                req.brust == INCR;
                req.addr >= 32'h40000000 && req.addr <= 32'h40002FFF;
            });

            finish_item(req);
        end

        wait(resp_cnt == 2);
    endtask
endclass

`endif



