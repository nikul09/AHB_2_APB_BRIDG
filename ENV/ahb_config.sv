
class ahb_config extends uvm_object;

    `uvm_object_utils(ahb_config)

    function new(string name = "ahb_config");
        super.new(name);
    endfunction

    static int NUM_INCR_TRANSFER;
    static int NUM_OF_WR_TRANS_REQ;
    static int NUM_OF_RD_TRANS_REQ;

    /* if number of transections and number of outstanding addresses are same 
       then transection work as a Normal Write Read Mode
    */
endclass


