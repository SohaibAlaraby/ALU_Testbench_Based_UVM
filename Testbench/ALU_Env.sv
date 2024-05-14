class ALU_Env extends uvm_env;
`uvm_component_utils(ALU_Env)

ALU_Agent alu_agt;
ALU_Scoreboard alu_scb;
ALU_Coverage_Collector alu_cvcl;

function new(string name="ALU_Env" , uvm_component parent = null);
    super.new(name,parent);
    `uvm_info(get_type_name(),"in ALU environment constructor", UVM_LOW)
endfunction

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_type_name(),"in ALU environment build_phase", UVM_LOW)
    alu_agt  = ALU_Agent::type_id::create("alu_agt",this);
    alu_scb  = ALU_Scoreboard::type_id::create("alu_scb",this);
    alu_cvcl = ALU_Coverage_Collector::type_id::create("alu_cvcl",this);
endfunction

function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info(get_type_name(),"in ALU environment connect_phase", UVM_LOW)
    alu_agt.alu_mon.monitor_port.connect(alu_scb.scb_port);
    alu_agt.alu_mon.monitor_port.connect(alu_cvcl.analysis_export);
endfunction

task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info(get_type_name(),"in ALU environment run_phase", UVM_LOW)
endtask


endclass
