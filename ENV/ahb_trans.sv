
`ifndef ahb_trans
`define ahb_trans

typedef enum bit{RD_REQ,WR_REQ}wr_rd_kind;
typedef enum bit[1:0]{OKAY,ERROR,RETRY,SPLIT}resp_kind;
typedef enum bit[2:0]{SINGLE,INCR,WRAP4,INCR4,WRAP8,INCR8,WRAP16,INCR16}hbrust_kind;
typedef enum bit[1:0]{IDLE,BUSY,NONSEQ,SEQ}htrans_kind;

class ahb_trans extends uvm_sequence_item;

    rand bit [`ADDR_WIDTH - 1 : 0] addr;
    rand bit [`DATA_WIDTH - 1 : 0] wdata[$];
    rand htrans_kind               trans[$];
    rand bit [`DATA_WIDTH - 1 : 0] rdata;
    rand resp_kind                 resp;
    rand bit [2 : 0]               size;
    rand hbrust_kind               brust;
    rand wr_rd_kind                wr_rd;

    ahb_config cnf;

    int byte_trans;
    int lower_boundary;
    int upper_boundary;

    bit [`ADDR_WIDTH - 1 : 0] tmp_addr[$];

    `uvm_object_utils_begin(ahb_trans)
        `uvm_field_enum(wr_rd_kind,wr_rd,UVM_ALL_ON)
        `uvm_field_sarray_enum(htrans_kind,trans,UVM_ALL_ON)
        `uvm_field_enum(hbrust_kind,brust,UVM_ALL_ON)
        `uvm_field_int(addr,UVM_ALL_ON)
        `uvm_field_queue_int(wdata,UVM_ALL_ON)
        `uvm_field_int(rdata,UVM_ALL_ON)
        `uvm_field_int(size,UVM_ALL_ON)
        `uvm_field_enum(resp_kind,resp,UVM_ALL_ON)
        `uvm_field_int(lower_boundary,UVM_ALL_ON)
        `uvm_field_int(upper_boundary,UVM_ALL_ON)
        `uvm_field_queue_int(tmp_addr,UVM_ALL_ON)
    `uvm_object_utils_end

    /* constraint to calculate size of wdata, Trans, address queue size */

    constraint wdata_trans_que_size{
        if(brust == SINGLE)                     wdata.size() == 1;
        if(brust == INCR)                       wdata.size() == cnf.NUM_INCR_TRANSFER;
        if(brust == INCR4 || brust == WRAP4)    wdata.size() == 4;
        if(brust == INCR8 || brust == WRAP8)    wdata.size() == 8;
        if(brust == INCR16 || brust == WRAP16)  wdata.size() == 16;
    }

    /* Function to hold calculations of wrap boundries calculations */
    
    constraint const_hbrust_size{
        trans.size() == wdata.size();

        if(brust == SINGLE){
            trans[0] inside {NONSEQ};
        }
        else{
            foreach(trans[i]){
                if(i == 0) trans[i] == NONSEQ;
                else trans[i] == SEQ;
            }
        }
    }

    /* constraint for validate size */

    constraint valid_size{
        size inside {[0:2]};
    }

    /* address must be allighned in AHB */

    constraint alig_addr{
        addr == (int'(addr / 2**size) ) * (2**size);
    }

    /* Function to hold calculations of wrap boundries calculations */

    function void wrap_boundry_calculations();
        byte_trans = (trans.size()) * (2**size);
        lower_boundary = (int'(addr/byte_trans)) * byte_trans;
        upper_boundary = lower_boundary + byte_trans;
    endfunction

    function new(string name = "Ahb_trans");
        super.new(name);
        cnf = ahb_config::type_id::create("cnf");
    endfunction

    function void post_randomize();
        if(brust == WRAP4 || brust == WRAP8 || brust == WRAP16) wrap_boundry_calculations();
    endfunction

endclass

`endif



// ------------------------ GARBAGE CODE ---------------------- //

    /* AHB support Only Aligh Address */
   /* 
    constraint alighn_addr{
        foreach(addr[i]){
            (addr[i] % size) == 0;
        }
    }
*/
    /*

    constraint Incr_addr_calculation{
        if(brust == INCR4){
            foreach(addr[i]){
                if(i != 0){
                    addr[i] == addr[i] + 4;
                }
            }
        }

        else if(brust == INCR8){
            foreach(addr[i]){
                if(i != 0){
                    addr[i] == addr[i] + 8;
                }
            }
        }

        else if(brust == INCR16){
            foreach(addr[i]){
                if(i != 0){
                    addr[i] == addr[i] + 16;
                }
            }
        }

    }
*/

