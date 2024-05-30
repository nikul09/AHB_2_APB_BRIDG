
`ifndef ahb_apb_wrap_sqn
`define ahb_apb_wrap_sqn

class ahb_apb_wrap4_sqn extends ahb_base_sqn;

    `uvm_object_utils(ahb_apb_wrap4_sqn)

    function new(string name = "ahb_apb_wrap4_sqn");
        super.new(name);
        `uvm_info(get_type_name(),"inside constructor",UVM_LOW)
    endfunction

    task body();
        super.body();
        repeat(1)begin

            req = ahb_trans::type_id::create("req");
            
            start_item(req);
	  
            assert(req.randomize() with {
                req.wr_rd == WR_REQ;
                req.size == 2;
                req.brust == WRAP4;
                req.addr >= 32'h40000000 && req.addr <= 32'h40002FFF;
            });

            finish_item(req);
        end

        wait(resp_cnt == 1);
    endtask
endclass

class ahb_apb_wrap8_sqn extends ahb_base_sqn;

    `uvm_object_utils(ahb_apb_wrap8_sqn)

    function new(string name = "ahb_apb_wrap8_sqn");
        super.new(name);
        `uvm_info(get_type_name(),"inside constructor",UVM_LOW)
    endfunction

    task body();
        super.body();
        repeat(1)begin

            req = ahb_trans::type_id::create("req");
            
            start_item(req);
	  
            assert(req.randomize() with {
                req.wr_rd == WR_REQ;
                req.size == 2;
                req.brust == WRAP8;
                req.addr >= 32'h40000000 && req.addr <= 32'h40001FFF;
            });

            finish_item(req);
        end

        wait(resp_cnt == 1);
    endtask
endclass

class ahb_apb_wrap16_sqn extends ahb_base_sqn;

    `uvm_object_utils(ahb_apb_wrap16_sqn)

    function new(string name = "ahb_apb_wrap4_sqn");
        super.new(name);
        `uvm_info(get_type_name(),"inside constructor",UVM_LOW)
    endfunction

    task body();
        super.body();
        repeat(1)begin

            req = ahb_trans::type_id::create("req");
            
            start_item(req);
	  
            assert(req.randomize() with {
                req.wr_rd == WR_REQ;
                req.size == 2;
                req.brust == WRAP16;
                req.addr >= 32'h40000000 && req.addr <= 32'h40002FFF;
            });

            finish_item(req);
        end

        wait(resp_cnt == 1);
    endtask
endclass

`endif



