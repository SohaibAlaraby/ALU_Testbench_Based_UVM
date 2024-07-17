class ALU_Test extends uvm_test;
`uvm_component_utils(ALU_Test)

ALU_Env env;
rst_sequence rst_seq;
test_sequence tst_seq;
function new(string name="ALU_Test", uvm_component parent = null);
    super.new(name , parent);
    `uvm_info(get_type_name(),"in ALU_Test constructor",UVM_LOW)
endfunction 

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = ALU_Env::type_id::create("env",this);
    `uvm_info(get_type_name(),"in ALU_Test build phase",UVM_LOW)
endfunction:build_phase

function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info(get_type_name(),"in ALU_Test connect phase",UVM_LOW)
endfunction:connect_phase

function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    `uvm_info(get_type_name(),"in ALU_Test end_of_elaboration_phase",UVM_LOW)
    this.print();
    factory.print();
endfunction:end_of_elaboration_phase
task run_phase(uvm_phase phase);

    super.run_phase(phase);
    `uvm_info(get_type_name(),"in ALU_Test run phase",UVM_LOW)

    phase.raise_objection(this);
   
    rst_seq = rst_sequence::type_id::create("rst_seq");
    rst_seq.start(env.alu_agt.alu_sequencer);
   
    repeat(80000) begin
        #20
        tst_seq= test_sequence::type_id::create("tst_seq");
        tst_seq.start(env.alu_agt.alu_sequencer);
    end

    phase.drop_objection(this);
endtask:run_phase

endclass:ALU_Test
