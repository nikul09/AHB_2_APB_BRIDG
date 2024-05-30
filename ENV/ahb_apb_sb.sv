

`uvm_analysis_imp_decl(_ahb)
`uvm_analysis_imp_decl(_apb)

class ahb_apb_sb extends uvm_scoreboard;

    uvm_analysis_imp_ahb#(ahb_trans,ahb_apb_sb)ahb_ip;
    uvm_analysis_imp_apb#(apb_trans,ahb_apb_sb)apb_ip;

   `uvm_component_utils(ahb_apb_sb);

   function new(string name = "ahb_apb_sb",uvm_component parent);
       super.new(name,parent);
   endfunction

   function void build_phase(uvm_phase phase);
       super.build_phase(phase);
       ahb_ip = new("ahb_ip",this);
       apb_ip = new("apb_ip",this);
   endfunction

    task write_ahb(ahb_trans ahb_trans_h);
        `uvm_info(get_name(),"AHB WRITE METHOD",UVM_NONE)
        ahb_trans_h.print();
    endtask

    task write_apb(apb_trans apb_trans_h);
        `uvm_info(get_name(),"APB WRITE METHOD",UVM_NONE)
        apb_trans_h.print();
    endtask


endclass
