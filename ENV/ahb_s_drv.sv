
`ifndef ahb_s_drv
`define ahb_s_drv

class ahb_s_drv extends uvm_driver #(ahb_trans);

    //virtual ahb_inf vinf;

    apb_trans trans_h;

    bit[`ADDR_WIDTH - 1:0]mem[bit[`DATA_WIDTH - 1:0]];

    uvm_analysis_imp#(apb_trans,ahb_s_drv) s_drv_ip;
    
    `uvm_component_utils(ahb_s_drv)

    function new(string name = "Ahb_m_driver",uvm_component parent);
        super.new(name,parent);
        `uvm_info(get_type_name(),"AHB slave Driver Constructor !",UVM_LOW)
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_type_name(),"AHB slave Driver Build Phase !",UVM_NONE)
        s_drv_ip = new("s_drv_ip",this);
       // if(!uvm_config_db#(virtual ahb_inf)::get(this,"*","vinf",vinf))
         //   `uvm_fatal(get_type_name(),"Faild to Get infterface")
    endfunction

    task write(apb_trans trans_h);
        if(trans_h.wr_rd)begin
            mem[trans_h.addr] = trans_h.data;
        end
        else begin
            `uvm_info(get_name(),"// ---- SLAVE DRIVER [RD_REQ] ---- //",UVM_NONE)
        end
    endtask

    task run_phase(uvm_phase phase);
        `uvm_info(get_type_name(),"AHB slave Driver Run Phase !",UVM_NONE)
    endtask

endclass

`endif
