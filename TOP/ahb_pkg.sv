`ifndef ahb_pkg
`define ahb_pkg

`define ADDR_WIDTH 32
`define DATA_WIDTH 32

/* used in transection class */

typedef enum bit{RD_REQ,WR_REQ}wr_rd_kind;
typedef enum bit[1:0]{OKAY,ERROR,RETRY,SPLIT}resp_kind;
typedef enum bit[2:0]{SINGLE,INCR,WRAP4,INCR4,WRAP8,INCR8,WRAP16,INCR16}hbrust_kind;
typedef enum bit[1:0]{IDLE,BUSY,NONSEQ,SEQ}htrans_kind;

`define AHB_MDRV_CB ahb_vinf.m_drv
`define AHB_MMON_CB ahb_vinf.m_mon
`define APB_MMON_CB apb_vinf.m_mon

`define SMON_CB ahb_vinf.s_mon

`include "../INF/ahb_apb_inf.sv"
`include "../INF/apb_inf.sv"

package ahb_pkg;

    import uvm_pkg::*;

    `include "uvm_macros.svh"
    
    `include "ahb_config.sv"
    `include "../ENV/ahb_trans.sv"
    `include "../ENV/apb_trans.sv"
    
    `include "ahb_s_sqr.sv"
    `include "ahb_m_sqr.sv"

    `include "ahb_base_sqn.sv"
    `include "ahb_wr_rd_sqn.sv" 
    `include "ahb_apb_single_sqn.sv" 
    `include "ahb_apb_unb_incr_sqn.sv" 
    `include "ahb_apb_incr_sqn.sv" 
    `include "ahb_apb_wrap_sqn.sv" 

    `include "ahb_m_drv.sv"
    `include "ahb_s_drv.sv"
    `include "ahb_s_mon.sv"

    `include "ahb_m_mon.sv"
    `include "ahb_m_age.sv"
    `include "ahb_s_age.sv"
    `include "ahb_apb_sb.sv"
    `include "ahb_env.sv"

    `include "ahb_base_test.sv"
    `include "ahb_senity_test.sv"
    `include "ahb_apb_single_test.sv" 
    `include "ahb_apb_unb_incr_test.sv" 
    `include "ahb_apb_incr_test.sv" 
    `include "ahb_apb_wrap_test.sv" 

 endpackage

`endif

