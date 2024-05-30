
`ifndef ahb_s_mon
`define ahb_s_mon

//class ahb_s_mon extends uvm_monitor;

    /*
    virtual ahb_inf vinf;
    apb_trans trans_h;

    uvm_analysis_port#(apb_trans) s_mon_ap;

    `uvm_component_utils(ahb_s_mon)

    function new(string name =  "ahb_s_mon",uvm_component parent);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        `uvm_info(get_name(),"Build phase Slave Monitor",UVM_NONE)
        trans_h = apb_trans::type_id::create("trans_h"); 
        s_mon_ap = new("s_mon_ap",this);
        
        if(!uvm_config_db#(virtual ahb_inf)::get(this,"*","vinf",vinf))
            `uvm_fatal(get_type_name(),"Faild to Get infterface")
    endfunction

    task run_phase(uvm_phase phase);
        forever begin
            @(`SMON_CB);
            wait(`SMON_CB.PENABLE && `SMON_CB.HREADYout);
            trans_h.addr = `SMON_CB.PADDR;
            trans_h.data = `SMON_CB.PWDATA;
            trans_h.wr_rd = wr_rd_kind'(`SMON_CB.PWRITE);
            s_mon_ap.write(trans_h);
        end
    endtask
*/
 // endclass

`endif


