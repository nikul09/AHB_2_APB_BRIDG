
`ifndef ahb_senity_sqn
`define ahb_senity_sqn

class ahb_wr_rd_sqn extends ahb_base_sqn;

    `uvm_object_utils(ahb_wr_rd_sqn)

    int addr_que[$];

    function new(string name = "ahb_wr_rd_sqn");
        super.new(name);
        `uvm_info(get_type_name(),"inside constructor",UVM_LOW)
    endfunction

    task body();
        super.body();
        
        repeat(cnf.NUM_OF_WR_TRANS_REQ)begin

            req = ahb_trans::type_id::create("req");
            
            start_item(req);
	  
            assert(req.randomize() with {
                req.wr_rd == WR_REQ;
                req.size == 2;
                req.brust == INCR4;
                req.addr >= 32'h40000000 && req.addr <= 32'h40002FFF;
            });

            //addr_que.push_back(req.addr);

            finish_item(req);
        end

        wait(resp_cnt == cnf.NUM_OF_WR_TRANS_REQ);

        repeat(cnf.NUM_OF_RD_TRANS_REQ)begin

            req = ahb_trans::type_id::create("req");
            
            start_item(req);

            assert(req.randomize() with {
                req.wr_rd == RD_REQ;
                req.size == 2;
                req.brust == INCR4;
                req.addr >= 32'h40000000 && req.addr <= 32'h40002FFF;
            });

            finish_item(req);
        end

        wait(resp_cnt == cnf.NUM_OF_WR_TRANS_REQ + cnf.NUM_OF_RD_TRANS_REQ);
    endtask
endclass

`endif



