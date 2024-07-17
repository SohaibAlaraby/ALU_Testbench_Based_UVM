class ALU_Driver extends uvm_driver #(ALU_Sequence_Item);
`uvm_component_utils(ALU_Driver)
ALU_Sequence_Item item;
virtual ALU_interface intf;
function new(string name ="ALU_Driver" , uvm_component parent = null );
    super.new(name,parent);
    `uvm_info(get_type_name(),"in ALU_Driver constructor", UVM_LOW)
endfunction

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_type_name(),"in ALU_Driver build_phase", UVM_LOW)
    if(!(uvm_config_db #(virtual ALU_interface)::get(this,"*","intf",intf))) begin
        `uvm_error(get_type_name(),"Error, DUT interface is not found")   
    end
endfunction

function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info(get_type_name(),"in ALU_Driver connect_phase", UVM_LOW)
endfunction

task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info(get_type_name(),"in ALU_Driver constructor", UVM_LOW)
    forever begin
        item = ALU_Sequence_Item::type_id::create("item");
        seq_item_port.get_next_item(item);
        drive(item);
        seq_item_port.item_done();
    end
endtask

task drive(ALU_Sequence_Item item);
    @(intf.CLK)
    intf.Reset      <= item.Reset;
    intf.A          <= item.A;
    intf.B          <= item.B;
    intf.op_code    <= item.op_code;
    intf.C_in       <= item.C_in;

endtask
endclass:ALU_Driver
