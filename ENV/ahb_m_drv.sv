
`ifndef ahb_m_drv
`define ahb_m_drv

class ahb_m_drv extends uvm_driver #(ahb_trans);

    virtual ahb_inf ahb_vinf;
    ahb_config cnf;
    
    ahb_trans wr_trans_h;

    ahb_trans wr_req_addr_phase_trans_que[$];
    ahb_trans wr_req_data_phase_trans_que[$];

    `uvm_component_utils(ahb_m_drv)

    function new(string name = "Ahb_m_driver",uvm_component parent);
        super.new(name,parent);
        `uvm_info(get_type_name(),"AHB Master Driver Constructor !",UVM_LOW)
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        cnf = ahb_config::type_id::create("cnf");
        rsp = ahb_trans::type_id::create("rsp");
        `uvm_info(get_type_name(),"AHB Master Driver Build Phase !",UVM_NONE)
        if(!uvm_config_db#(virtual ahb_inf)::get(this,"*","ahb_vinf",ahb_vinf))
            `uvm_fatal(get_type_name(),"Faild to Get infterface")
    endfunction

    task run_phase(uvm_phase phase);

        reset_driver();
        wait(ahb_vinf.HRESETn);

        fork:DRV_FORK
            get_req();
            drive_wr_trans_data_phase();
            drive_wr_trans_addr_phase();
            put_resp();
        join_any

        wait(!ahb_vinf.HRESETn);
        disable DRV_FORK;

    endtask

    task reset_driver();
        wait(!ahb_vinf.HRESETn);
        `AHB_MDRV_CB.HTRANS <= htrans_kind'(0);
        `AHB_MDRV_CB.HBURST <= hbrust_kind'(0);
    endtask

    task get_req();
        `uvm_info(get_name()," RETRIVE PACKETS FROM SQR FIFO WITH GET METHOD",UVM_NONE)
        forever begin
            seq_item_port.get(req);
            wr_trans_h = new req;
            wr_req_addr_phase_trans_que.push_back(wr_trans_h);
            wr_req_data_phase_trans_que.push_back(wr_trans_h);
        end
    endtask

    task drive_wr_trans_addr_phase();
        `uvm_info(get_name()," DRIVE WRITE TRANSECTION ADDR PHASE",UVM_NONE)
        forever begin
            wait(wr_req_addr_phase_trans_que.size() != 0);
            @(`AHB_MDRV_CB)
            foreach(wr_req_addr_phase_trans_que[i])begin
                `AHB_MDRV_CB.HSIZE   <=  wr_req_addr_phase_trans_que[i].size;
                `AHB_MDRV_CB.HBURST  <=  hbrust_kind'(wr_req_addr_phase_trans_que[i].brust);
                `AHB_MDRV_CB.HWRITE  <=  wr_rd_kind'(wr_req_addr_phase_trans_que[i].wr_rd);
                `AHB_MDRV_CB.HADDR   <=  wr_req_addr_phase_trans_que[i].addr;
                `AHB_MDRV_CB.HTRANS  <=  htrans_kind'(wr_req_addr_phase_trans_que[i].trans[0]);
                 @(`AHB_MDRV_CB);
                wait(`AHB_MDRV_CB.HREADYout);
                for(int j = 0;j< wr_req_addr_phase_trans_que[i].trans.size() - 1;j++)begin
                    wr_req_addr_phase_trans_que[i].addr =  wr_req_addr_phase_trans_que[i].addr + 
                                                   (2 ** wr_req_addr_phase_trans_que[i].size);

                    /* check frist if request is wrap type then calculate wrap boundry */

                    if(wr_req_addr_phase_trans_que[i].brust == WRAP4 ||
                       wr_req_addr_phase_trans_que[i].brust == WRAP8 ||
                       wr_req_addr_phase_trans_que[i].brust == WRAP16 )begin
                          
                          /* during increment if address reach at lower boundry then address jump to upper boundry */
                          
                          if(wr_req_addr_phase_trans_que[i].addr == wr_req_addr_phase_trans_que[i].upper_boundary)begin
                              wr_req_addr_phase_trans_que[i].addr = wr_req_addr_phase_trans_que[i].lower_boundary;
                          end
                    end

                    `AHB_MDRV_CB.HADDR   <=  wr_req_addr_phase_trans_que[i].addr;
                    `AHB_MDRV_CB.HTRANS  <=  htrans_kind'(wr_req_addr_phase_trans_que[i].trans[j + 1]);
                    @(`AHB_MDRV_CB);
                    wait(`AHB_MDRV_CB.HREADYout);
                end
            end
            wr_req_addr_phase_trans_que.delete();
        end
    endtask

    task drive_wr_trans_data_phase();
        `uvm_info(get_name()," DRIVE WRITE TRANSECTION ADDR PHASE",UVM_NONE)
        forever begin
            @(`AHB_MDRV_CB);
            wait(wr_req_data_phase_trans_que.size() != 0);
            foreach(wr_req_data_phase_trans_que[i])begin
                if(wr_req_data_phase_trans_que[i].wr_rd == WR_REQ)begin
                    for(int j=0;j< wr_req_data_phase_trans_que[i].trans.size() ;j++)begin
                         @(`AHB_MDRV_CB);
                        `AHB_MDRV_CB.HWDATA   <=  wr_req_data_phase_trans_que[i].wdata[j];
                         @(`AHB_MDRV_CB);
                         wait(`AHB_MDRV_CB.HREADYout);
                    end
                end
            end
            wr_req_data_phase_trans_que.delete();
        end
    endtask

    task put_resp();
        `uvm_info(get_name()," PUT RESPONSE !",UVM_NONE)
        forever begin
            @(`AHB_MDRV_CB);
            if(ahb_vinf.HTRANS == NONSEQ && ahb_vinf.HREADYout)begin
                rsp = ahb_trans::type_id::create("rsp");
                rsp.set_id_info(req);
                rsp.resp = resp_kind'(`AHB_MDRV_CB.HRESP);
                seq_item_port.put(rsp);
            end
        end

    endtask

endclass

`endif

