
`ifndef ahb_m_mon
`define ahb_m_mon

class ahb_m_mon extends uvm_monitor;

    virtual ahb_inf ahb_vinf;
    virtual apb_inf apb_vinf;

    ahb_trans trans_h_ahb;
    apb_trans trans_h_apb;
    
    int tmp_size;
    
    `uvm_component_utils(ahb_m_mon)

    uvm_analysis_port#(ahb_trans) ahb_mon_ap;
    uvm_analysis_port#(apb_trans) apb_mon_ap;
    
    function new(string name =  "ahb_m_mon",uvm_component parent);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        `uvm_info(get_name(),"Build phase Slave Monitor",UVM_NONE)
        
        ahb_mon_ap = new("ahb_mon_ap",this);
        apb_mon_ap = new("apb_mon_ap",this);
        
        if(!uvm_config_db#(virtual ahb_inf)::get(this,"*","ahb_vinf",ahb_vinf))
            `uvm_fatal(get_type_name(),"Faild to Get infterface")

        if(!uvm_config_db#(virtual apb_inf)::get(this,"*","apb_vinf",apb_vinf))
            `uvm_fatal(get_type_name(),"Faild to Get infterface")
    endfunction

    task run_phase(uvm_phase phase);
        fork
            sample_apb_control_data_phase();
            sample_ahb_control_data_phase();
        join
    endtask

    task sample_apb_control_data_phase();
        forever begin
            @(`APB_MMON_CB);

            trans_h_apb = new();

            /* wait untill handshaking single going to HIGH, APB have PENABLE or PHREADY */

            wait(`APB_MMON_CB.PENABLE && `AHB_MMON_CB.HREADYout);

            /* sample address and data phase of apb */

            trans_h_apb.addr = `APB_MMON_CB.PADDR;
            trans_h_apb.data = `APB_MMON_CB.PWDATA;
            trans_h_apb.wr_rd = wr_rd_kind'(`APB_MMON_CB.PWRITE);

            /* put transection in write method after sample */

            apb_mon_ap.write(trans_h_apb);
        end

    endtask

    task sample_ahb_control_data_phase();
        forever begin

            /* at every transection packet gatting new memory */
            
            trans_h_ahb = new;
            
            while(1)begin
                @(`AHB_MMON_CB);

                /* wait untill handshaking single high, AHB have HTRANS and HREADYout */

                wait(`AHB_MMON_CB.HTRANS != 0 && `AHB_MMON_CB.HREADYout);

                /* mapping Htrans enum with constant integer value */

                if(`AHB_MMON_CB.HTRANS == 2)begin
                    case(`AHB_MMON_CB.HBURST)
                        SINGLE : tmp_size = 1;
                        INCR4  : tmp_size = 4; 
                        INCR8  : tmp_size = 8; 
                        INCR16 : tmp_size = 16; 
                        WRAP4  : tmp_size = 4; 
                        WRAP8  : tmp_size = 8; 
                        WRAP16 : tmp_size = 16;
                    endcase
                end

                /* made packet after sampled form interface */

                trans_h_ahb.tmp_addr.push_back(`AHB_MMON_CB.HADDR);
                if(`AHB_MMON_CB.HWDATA)trans_h_ahb.wdata.push_back(`AHB_MMON_CB.HWDATA);
                trans_h_ahb.trans.push_back(`AHB_MMON_CB.HTRANS);
                trans_h_ahb.size = `AHB_MMON_CB.HSIZE;
                trans_h_ahb.brust = `AHB_MMON_CB.HBURST;

                /* temp size work as doun counter, decrese untill brust type */

                tmp_size--;

                /* if temp variable size is 0 then put packets into write method */

                if(!tmp_size)begin
                    //trans_h_ahb.print();
                    ahb_mon_ap.write(trans_h_ahb);

                    /* delete memory of transection class, due to for next transection data not mix with previes */
                    
                    trans_h_ahb = null;

                    /* break while loop when, pertculer one transection have data according to size and len */

                    break;
                end

            end
        end
    endtask
endclass

`endif
