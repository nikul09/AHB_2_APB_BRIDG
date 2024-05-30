
`ifndef apb_trans
`define apb_trans

class apb_trans extends uvm_sequence_item;

    rand bit [`ADDR_WIDTH - 1 : 0] addr;
    rand bit [`DATA_WIDTH - 1 : 0] data;
    rand wr_rd_kind                wr_rd;

    `uvm_object_utils_begin(apb_trans)
        `uvm_field_enum(wr_rd_kind,wr_rd,UVM_ALL_ON)
        `uvm_field_int(addr,UVM_ALL_ON)
        `uvm_field_int(data,UVM_ALL_ON)
    `uvm_object_utils_end

    function new(string name = "apb_trans");
        super.new(name);
    endfunction

  endclass

`endif

