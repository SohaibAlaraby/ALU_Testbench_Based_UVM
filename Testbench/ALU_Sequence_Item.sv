class ALU_Sequence_Item extends uvm_sequence_item;
`uvm_object_utils(ALU_Sequence_Item)

rand logic       Reset;
rand logic[7:0]  A,B;
rand logic[3:0]  op_code;
rand bit         C_in;
logic[15:0] Result;
bit         C_out, Z_flag;

constraint op_code_c {
    op_code inside {[0:5]};
}

// constraint stimilus_c {
//     A > B;
// }

function new(string name="ALU_Sequence_Item");
    super.new(name);
    `uvm_info(get_type_name(),"in ALU_Sequence_Item constructor",UVM_HIGH)
endfunction : new



endclass: ALU_Sequence_Item
