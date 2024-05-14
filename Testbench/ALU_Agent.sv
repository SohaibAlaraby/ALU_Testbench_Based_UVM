class ALU_Agent extends uvm_agent;

`uvm_component_utils(ALU_Agent)

ALU_monitor alu_mon;
ALU_Sequencer alu_sequencer;
ALU_Driver alu_driver;

function new(string name="ALU_Agent" , uvm_component parent = null);
    super.new(name,parent);
    `uvm_info(get_type_name(),"in ALU Agent constructor", UVM_LOW)
endfunction

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_type_name(),"in ALU Agent build_phase", UVM_LOW)
    alu_mon  = ALU_monitor::type_id::create("ALU_monitor",this);
    alu_sequencer  = ALU_Sequencer::type_id::create("ALU_Sequencer",this);
    alu_driver  = ALU_Driver::type_id::create("ALU_Driver",this);
  
endfunction

function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info(get_type_name(),"in ALU Agent connect_phase", UVM_LOW)
    //connect sequencer and driver
    alu_driver.seq_item_port.connect(alu_sequencer.seq_item_export);
endfunction

task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info(get_type_name(),"in ALU Agent run_phase", UVM_LOW)
endtask
endclass
